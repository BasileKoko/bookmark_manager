feature 'filter tags' do
  scenario 'display tags with bubbles' do
    visit '/tags/bubbles'
    expect(page).to have_content "bubbles"
  end
end
