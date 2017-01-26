feature 'organise links into categories' do
  scenario 'tag links' do
    visit '/new'
    fill_in 'title', with: 'BBC News'
    fill_in 'url', with: 'www.bbc.co.uk'
    fill_in 'tags', with: 'news'
    click_button 'Submit'
    # expect(page).to have_content 'tags:news'
    link = Link.first
    expect(link.tags.map(&:name)).to include('news')
  end

  scenario 'I can add multiple tags to a new link' do
    visit '/new'
    fill_in 'url',   with: 'http://www.makersacademy.com'
    fill_in 'title', with: 'Makers Academy'
    # our tags will be space separated
    fill_in 'tags',  with: 'education ruby'
    click_button 'Submit'
    link = Link.first
    visit '/links'
    expect(link.tags.map(&:name)).to include('education', 'ruby')
    within 'ul#links' do
      expect(page).to have_content('Title: Makers Academy URL: http://www.makersacademy.com Tags: education, ruby')
    end
  end
end
