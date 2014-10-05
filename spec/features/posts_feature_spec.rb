require 'rails_helper'

describe 'posts' do

  context 'no posts have been added' do

    it 'should display a prompt to add a post' do
      visit '/posts'
      expect(page).to have_content "No posts yet"
      expect(page).to have_link "Make a post"
    end
  end

  context 'posts have been added' do
    before do
      Post.create(description: "My first nudibranch")
    end

    it 'should display them' do
      visit '/posts'
      expect(page).to have_content "My first nudibranch"
      expect(page).not_to have_content "No posts yet"
    end
  end
end

describe 'creating posts' do
  it 'prompts the user to fill out a form then displays the new post' do
    visit '/posts'
    click_link 'Make a post'
    fill_in 'Description', with: "My first nudibranch"
    click_button 'Create post'
    expect(page).to have_content "My first nudibranch"
    expect(current_path).to eq '/posts'
  end
end

describe 'editing posts' do

  before do
    Post.create(description: "My first nudibranch")
  end

   it 'can allow a user to edit a post' do
    visit '/posts'
    click_link 'Edit post'
    fill_in 'Description', with: "Still the same nudibranch"
    click_button 'Update post'
    expect(page).to have_content "Still the same nudibranch"
    expect(current_path).to eq '/posts'
  end
end



















