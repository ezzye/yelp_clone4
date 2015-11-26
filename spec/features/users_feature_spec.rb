require 'rails_helper'

feature "User can sign in and out" do
  context "user not signed in and on the homepage" do
    it "should see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    it "should not see 'sign out' link" do
      visit('/')
      expect(page).not_to have_link('Sign out')
    end
  end

  context "user signed in on the homepage" do
    before do
      visit('/')
      click_link('Sign up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
    end

    it "should see 'sign out' link" do
      visit('/')
      expect(page).to have_link('Sign out')
    end

    it "should not see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end
  end

  context "Limiting users" do
    context "User tries to delete a restaurant they did not create" do
        it "Should raise an error" do
          signup_and_create_and_signup_again
          click_link('Delete KFC')
          expect(page).to have_content("You are not the owner of this restaurant.")
        end
    end

    context "User tries to edit a restaurant they did not create" do
      it "Should raise an error" do
        signup_and_create_and_signup_again
        click_link('Edit KFC')
        click_button('Update Restaurant')
        expect(page).to have_content("You are not the owner of this restaurant.")
      end
    end

    context "User tries to leave a second review for a restaurant" do
      it "Should raise an error" do
        signup_signin
        create_restaurant
        review_restaurant
        click_link("Review KFC")
        click_button("Leave Review")
        expect(page).to have_content("You have already reviewed this restaurant")
      end
    end

  end
end
