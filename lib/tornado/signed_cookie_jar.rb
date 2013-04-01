module Tornado
  class SignedCookieJar < ActionDispatch::Cookies::SignedCookieJar
    def initialize(parent_jar, key_generator, options = {})
      @parent_jar = parent_jar
      @options = options
      secret = Resonanz::Application.config.secret_key_base
      @verifier = MessageVerifier.new(secret)
    end

    def [](key)
      if signed_message = @parent_jar[key]
        @verifier.verify(key, signed_message)
      end
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      nil
    end

    def []=(key, options)
      timestamp = Time.now.to_i

      if options.is_a?(Hash)
        options.symbolize_keys!
        options[:value] = @verifier.generate(key, options[:value], timestamp)
      else
        options = {:value => @verifier.generate(key, options, timestamp)}
      end

      raise ActionDispatch::Cookies::CookieOverflow if options[:value].size > ActionDispatch::Cookies::MAX_COOKIE_SIZE
      @parent_jar[key] = options
    end

    def signed
      @signed ||= SignedCookieJar.new(self, @key_generator, @options)
    end
  end
end