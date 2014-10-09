require 'rails_helper'

describe 'posts' do

  before do
    chris = create(:chris)
    login_as(chris, :scope => :user)
  end

  context 'no posts have been added' do

    it 'should display a prompt to add a post' do
      visit '/posts'
      expect(page).to have_content "No posts yet"
      expect(page).to have_link "Make a post"
    end
  end

  context 'posts have been added' do
    before do
    visit '/posts'
    click_link 'Make a post'
    attach_file('Image', 'spec/features/nb1.jpg')
    fill_in 'Description', with: "My first nudibranch"
    click_button 'Create post'
    end

    it 'should display them' do
      visit '/posts'
      click_link 'Make a post'
      attach_file('Image', 'spec/features/nb1.jpg')
      fill_in 'Description', with: "My first nudibranch"
      click_button 'Create post'
      expect(page).to have_content "My first nudibranch"
      expect(page).not_to have_content "No posts yet"
    end
  end
end

describe 'showing the the full page of the post' do
  before do
    chris = create(:chris)
    login_as(chris, :scope => :user)
    visit '/posts'
    click_link 'Make a post'
    attach_file('Image', 'spec/features/nb1.jpg')
    fill_in 'Description', with: "Nudibranch"
    click_button 'Create post'
  end

  it 'shows the full page of the post when the link is clicked' do
    visit '/posts'
    click_link 'Show post'
    Nudibranch_id = Post.find_by(description: 'Nudibranch').id
    expect(current_path).to eq "/posts/#{ Nudibranch_id }"
    expect(page).to have_content "Nudibranch"
    click_link 'Back to index'
    expect(current_path).to eq '/posts'
  end
end

describe 'creating posts' do

  before do
    chris = create(:chris)
    login_as(chris, :scope => :user)
  end

  it 'prompts the user to fill out a form then displays the new post' do
    visit '/posts'
    click_link 'Make a post'
    attach_file('Image', 'spec/features/nb1.jpg')
    fill_in 'Description', with: "My first nudibranch"
    click_button 'Create post'
    expect(page).to have_css 'img'
    expect(page).to have_content "My first nudibranch"
    expect(current_path).to eq '/posts'
  end
end

describe 'editing posts' do

  before do
    chris = create(:chris)
    login_as(chris, :scope => :user)
    # Post.create(description: "My first nudibranch")
  end

   it 'can allow a user to edit a post' do
    visit '/posts'
    click_link 'Make a post'
    attach_file('Image', 'spec/features/nb1.jpg')
    fill_in 'Description', with: "My first nudibranch"
    click_button 'Create post'
    click_link 'Edit post'
    fill_in 'Description', with: "Still the same nudibranch"
    click_button 'Update post'
    expect(page).to have_content "Still the same nudibranch"
    expect(current_path).to eq '/posts'
  end
end

describe 'deleting posts' do

  before do
    chris = create(:chris)
    login_as(chris, :scope => :user)
    visit '/posts'
    click_link 'Make a post'
    attach_file('Image', 'spec/features/nb1.jpg')
    fill_in 'Description', with: "My first nudibranch"
    click_button 'Create post'
  end

  it 'removes a post when the user clicks delete post' do
    visit '/posts'
    click_link 'Delete post'
    expect(page).not_to have_content "My first nudibranch"
    expect(page).to have_content "Post successfully deleted"
  end
end

describe 'displaying posts' do

  it 'the post should have the email of the poster diplayed beside it on the homepage' do
    chris = create(:chris)
    login_as(chris, :scope => :user)
    visit '/posts'
    click_link 'Make a post'
    attach_file('Image', 'spec/features/nb1.jpg')
    fill_in 'Description', with: "Nudibranch"
    click_button 'Create post'
    expect(page).to have_content "by chris@factorygirl.com"
  end
end





















