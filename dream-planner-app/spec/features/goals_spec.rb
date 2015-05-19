require 'spec_helper'
require 'rails_helper'




feature "creating a goal" do
  let(:user) { create(:user) }
  before(:each) do
    sign_in_as(user)
    visit("goals/new")
  end

  it "has a new goal page" do
    expect(page).to have_button("Create New Goal")
  end

  it "has a content field" do
    expect(page).to have_content("Content")
  end

  it "has a private/public field" do
    expect(page).to have_content("Private")
    expect(page).to have_content("Public")
  end

  it "has the public radio button checked as default" do
    expect(find_field('goal-public')).to be_checked
  end

  it "validates presence of content" do
    click_on("Create New Goal")
    expect(page).to have_content("Content can't be blank")
  end



  feature "creates the goal" do
    before(:each) do
      fill_in("goal-title", with: "example")
      fill_in("goal-content", with: "This is my goal")
      click_on("Create New Goal")
    end

    it "redirects to a show page" do
      expect(current_path).to match(/^\/users\/(\d)+/)
      expect(page).to have_content("This is my goal")
    end
  end

end

feature "reading a goal" do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  before(:each) do
    sign_in_as(user)
    1.times { create(:goal_public) }
    1.times { create(:goal_private) }
    click_on("#{user.username}")
  end

  it "has a user show page with all of the user's goals" do
    expect(page).to have_css('li', count: 2)
  end

  it "has an edit button for each goal" do
    expect(page).to have_button('Edit', count: 2)
  end

  it "only shows public goals for other user" do
    log_out
    sign_in_as(other_user)
    visit(user_url(user))
    expect(page).to have_css('li', count: 1)
    expect(page).to have_content('Public Goal')
  end

end

feature "editing a goal" do
  let(:user) { create(:user) }
  before(:each) do
    sign_in_as(user)
    create(:goal_pizza)
    visit(user_url(user))
    click_on("Edit")
  end

  it "has an edit goal page" do
    expect(page).to have_button("Edit Goal")
  end

  it "includes a pre-filled content field" do
    expect(page).to have_content("Content")
    expect(find_field('goal-content').value).to eq("Eat more pizza")
  end

  it "has a prefilled private/public field" do
    expect(find_field('goal-private')).to be_checked
  end

  it "has errors if updating fails" do
    fill_in('goal-content', with: "")
    click_on("Edit Goal")
    expect(page).to have_content("Content can't be blank")
  end

end

feature "deleting a goal" do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  before(:each) do
    sign_in_as(user)
    create(:goal_pizza)
    visit(user_url(user))
  end

  it "has a delete button" do
    expect(page).to have_button('Delete')
  end

  it "does not have a delete button for other user" do
    log_out
    sign_in_as(other_user)
    visit(user_url(user))
    expect(page).to_not have_button('Delete')
  end

  it "deletes goal upon success" do
    click_on('Delete')
    expect(page).to_not have_content("Eat more pizza")
  end
end

feature "user can complete a goal" do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  before(:each) do
    sign_in_as(user)
    create(:goal_pizza)
    visit(user_url(user))
  end

  it "should default to be incomplete" do
    expect(page).to have_content("Incomplete")
  end

  it "should be able to be completed" do
    click_on("Complete Goal")
    expect(page).to have_content("Complete")
  end

  it "is limited to the goal's owner" do
    log_out
    sign_in_as(other_user)
    visit(user_url(user))
    expect(page).to_not have_button("Complete Goal")
  end


end
# feature "updating a goal" do
#
#   it "has a new user page" do
#     visit("users/new")
#     expect(page).to have_button("Sign Up")
#   end
#
#
# end
# feature "deleting a goal" do
#
#   it "has a new user page" do
#     visit("users/new")
#     expect(page).to have_button("Sign Up")
#   end
# end
