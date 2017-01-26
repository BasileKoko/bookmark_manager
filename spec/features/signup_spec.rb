feature 'user signup' do
  scenario 'enter email and password' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page.current_path).to eq '/links'
    expect(page).to have_content 'test@hotmail.com'
  end
  scenario 'with a password that does not match' do
    expect { sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
    expect(current_path).to eq('/users') # current_path is a helper provided by Capybara
    expect(page).to have_content 'Password and confirmation password do not match'
  end
end
