# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Resonanz::Application.config.secret_key_base = 'SOME_SECRET_HERE'

# set Tornado::SignedCookieJar
signed_cookie_jar = Module.new do
  def signed
    @signed ||= Tornado::SignedCookieJar.new(self, @key_generator, @options)
  end
end

ActionDispatch::Cookies::PermanentCookieJar.send(:prepend, signed_cookie_jar)
ActionDispatch::Cookies::EncryptedCookieJar.send(:prepend, signed_cookie_jar)
ActionDispatch::Cookies::CookieJar.send(:prepend, signed_cookie_jar)

# unescaped cookies
class << Rack::Utils
  alias :origin_set_cookie_header! set_cookie_header!

  def set_cookie_header!(header, *args)
    return_value = origin_set_cookie_header!(header, *args)

    header["Set-Cookie"] = unescape(header["Set-Cookie"] || '')

    return_value
  end
end