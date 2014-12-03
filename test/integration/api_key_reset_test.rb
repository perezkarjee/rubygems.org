require 'test_helper'

class ApiKeyResetTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    cookies[:remember_token] = @user.remember_token
  end

  test "user sees key on profile" do
    get edit_profile_path

    assert_response :success
    assert page.has_content? @user.api_key
  end

  test "user resets api key" do
    put reset_api_v1_api_key_path
    assert_response :redirect

    get edit_profile_path

    assert_response :success
    assert page.has_content? @user.reload.api_key
  end
end
