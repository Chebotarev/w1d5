require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  it "has a new user page" do
    visit("users/new")
    expect(page).to have_content("Sign Up")
  end

  feature "signing up a user" do

    it "shows username on the homepage after signup" do
      user = create(:user)
      sign_up_as(user)
      expect(page).to have_content(user.username)
    end

  end

end

feature "logging in" do

  it "shows username on the homepage after login" do
    user = create(:user)
    sign_up_as(user)
    log_out
    sign_in_as(user)
    expect(page).to have_content(user.username)
  end

end

feature "logging out" do
  before(:each) do
    user = create(:user)
    sign_up_as(user)
    log_out
  end

  it "begins with logged out state" do
    expect(page).to have_button("Sign In")
  end

  it "doesn't show username on the homepage after logout" do
    expect(page).to_not have_content(user.username)
  end

end
