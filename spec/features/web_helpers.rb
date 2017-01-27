require 'database_cleaner'

def reset_database

 RSpec.configure do |config|
   # Everything in this block runs once before all the tests run
   config.before(:suite) do
     DatabaseCleaner.strategy = :transaction
     DatabaseCleaner.clean_with(:truncation)
   end

   # Everything in this block runs once before each individual test
   config.before(:each) do
     DatabaseCleaner.start
   end
   config.after(:each) do
     DatabaseCleaner.clean
   end
 end
end

def sign_in(email:, password:)
  visit '/sessions/new'
  fill_in :email, with: email
  fill_in :password, with: password
  click_button 'Sign in'
  end

  def sign_up(email: 'test@hotmail.com',
                password: '12345678',
                password_confirmation: '12345678')
    visit '/signup'
    fill_in 'email', with: email
    fill_in 'password', with: password
    fill_in 'password_confirmation', with: password_confirmation
    click_button 'sign_up'
  end
