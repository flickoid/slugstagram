require 'rails_helper'

describe 'likes' do

  before do
    chris = create(:chris)
    login_as(chris, :scope => :user)
    visit '/posts'
    click_link 'Make a post'
    attach_file('Image', 'spec/features/nb1.jpg')
    fill_in 'Description', with: "Nudibranch"
    click_button 'Create post'
  end

  it 'can like a post, updating the like count', js: true do
    visit '/posts'
    click_link 'Like this post'
    expect(page).to have_content '1 like'
  end

  it 'can like like a post more than once, updating the like count', js: true do
    visit '/posts'
    click_link 'Like this post'
    click_link 'Like this post'
    expect(page).to have_content '2 likes'
  end
end