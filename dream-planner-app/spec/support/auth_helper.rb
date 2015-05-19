module AuthHelper
  def sign_up_as(user)
    visit('users/new')
    fill_in("user_username", with: user.username)
    fill_in("user_password", with: user.password)
    click_on('Sign Up')
  end

  def sign_in_as(user)
    visit('/session/new')
    fill_in("user_username", with: user.username)
    fill_in("user_password", with: user.password)
    click_on('Sign In')
  end

  def log_out
    click_on('Log Out')
  end
end
