require 'rails_helper'

describe 'likes' do

  before do
    chris = create(:chris)
    login_as(chris, :scope => :user)
    Post.create(description: "My first nudibranch")
  end

  it 'can like a post, updating the like count' do
    visit '/posts'
    click_link 'Like'
    expect(page).to have_content '1 like'
  end
end