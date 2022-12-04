require "rails_helper"

feature "User can delete an answer", %q{
  In order to get rid of wrong answers,
  As authenticated user,
  And as an author of a particular answer,
  I'd like to delete a answer
} do
  given(:user1) { create(:user) }
  given(:user2) { create(:user) }
  given!(:answer) { create(:answer, user: user1) }

  describe "Authenticated user" do
    scenario "delete his answer" do
      sign_in(user1)
      visit question_path(answer.question)
      click_on "Delete"

      expect(page).to_not have_content answer.body
      expect(page).to have_content "Your answer successfully deleted"
    end

    scenario "tries to delete answers from other people" do
      sign_in(user2)
      visit question_path(answer.question)

      expect(page).to_not have_content "Delete"
    end
  end

  scenario "Unauthenticated user tries to delete any answer" do
    visit question_path(answer.question)

    expect(page).to_not have_content "Delete"
  end
end
