module Tornado
  class MessageVerifier < ActiveSupport::MessageVerifier
    def verify(key, signed_message)
      raise InvalidSignature if signed_message.blank?

      value, timestamp, digest = signed_message.split('|')
      if value.present? && digest.present? && secure_compare(digest, generate_digest(key, value, timestamp))
        ::Base64.decode64(value)
      else
        raise ActiveSupport::MessageVerifier::InvalidSignature
      end
    end

    def generate(key, value, timestamp)
      value = ::Base64.strict_encode64(value.to_s)
      [value, timestamp, generate_digest(key, value, timestamp)].join('|')
    end

    private

    def generate_digest(*parts)
      require 'openssl' unless defined?(OpenSSL)

      hash = OpenSSL::HMAC.new(@secret, OpenSSL::Digest.const_get(@digest).new)
      parts.each do |part|
        hash.update(part.to_s)
      end

      hash.hexdigest
    end
  end
end