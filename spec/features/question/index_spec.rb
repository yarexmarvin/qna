require "rails_helper"

feature "User can see the list of questions", %q{
  In order to answer a question 
  Or/ and find a question
  I'd like to see the list of questions 
} do
  scenario "Anyone can see the list of questions" do
    user = create(:user)
    create_list(:question, 3, user: user)

    visit questions_path

    expect(page).to have_content "Questions"
    expect(page).to have_content "MyString"
  end
end
