feature 'user signup' do
  scenario 'enter email and password' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page.current_path).to eq '/links'
    expect(page).to have_content 'test@hotmail.com'
  end
end
