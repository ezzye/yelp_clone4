require 'spec_helper'

def signup_and_create_and_signup_again
  visit('/')
  click_link('Sign up')
  fill_in('Email', with: 'test@example.com')
  fill_in('Password', with: 'testtest')
  fill_in('Password confirmation', with: 'testtest')
  click_button('Sign up')
  click_link 'Add a restaurant'
  fill_in 'Name', with: 'KFC'
  click_button 'Create Restaurant'
  click_link 'Sign out'
  visit('/')
  click_link('Sign up')
  fill_in('Email', with: 'test2@example.com')
  fill_in('Password', with: 'testtest')
  fill_in('Password confirmation', with: 'testtest')
  click_button('Sign up')
end

def review_restaurant
  click_link('Review KFC')
  fill_in('Thoughts', with: 'I love chicken')
  click_button('Leave Review')
end
