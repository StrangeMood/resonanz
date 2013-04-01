require 'test_helper'

class AuthTest < ActionDispatch::IntegrationTest
  setup do
    secret = Resonanz::Application.config.secret_key_base
    @verifier = Tornado::MessageVerifier.new(secret)

    @timestamp = Time.now.to_i

    @user = User.create
    @valid_cookie = @verifier.generate(:id, @user.id, @timestamp)
  end

  test 'create identity for new users' do
    Time.stub(:now, Time.at(@timestamp)) do
      get '/'
      assert :found, 'should redirect users without identity'

      follow_redirect!

      assert_equal '/create_identity', path
      assert :found, 'should redirect back to root'
      assert_not_nil @controller.current_user
      assert_equal @verifier.generate(:id, @controller.current_user.id, @timestamp), cookies['id']
    end
  end

  test 'bypass identity creation with valid id cookie' do
    get '/', {}, {'HTTP_COOKIE' => "id=#@valid_cookie; "}

    assert_equal @user, @controller.current_user
    assert response.success?
  end

  test 'block users with invalid id cookie' do
    another_user = User.create
    invalid_id_cookie = @valid_cookie.sub(/^[^\|]+/, Base64.strict_encode64(another_user.id.to_s))

    get '/', {}, {'HTTP_COOKIE' => "id=#{invalid_id_cookie}; "}

    assert_nil @controller.current_user
    assert :found, 'should redirect to create identity'
  end
end
