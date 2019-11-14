require 'rails_helper'

feature "auth features", type: :feature do
  feature "the signup process" do
    scenario "has a new user page" do
      visit new_user_url
      expect(page).to have_content "Sign Up"
    end
    
    feature "signing up a user" do
      before(:each) do
        visit new_user_url
        fill_in 'Email', :with => "asdf1@gmail.com"
        fill_in 'Password', :with => "password"
        click_on "Sign Up"
      end

      scenario "redirects to bands index page after signup" do
        visit bands_url
        expect(page).to have_content "Bands"
      end
    end

    feature "with an invalid user" do
      before(:each) do
        visit new_user_url
        fill_in 'Email', :with => "testing@email.com"
        click_on "Sign Up"
      end

      scenario "re-renders the signup page after failed signup" do
        visit new_user_url
        expect(page).to have_content "Sign Up"
      end
    end

  end

end