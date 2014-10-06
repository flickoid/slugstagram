require 'rails_helper'

describe 'OmniAuth' do
  before do
    visit "/users/auth/facebook"
  end

  it 'signing in with correct credentials' do
    expect(page).to have_link "Sign out"
  end

  it 'should successfully create a user' do
    expect(User.count).to eq(1)
  end

  it 'should redirect the user to the index page' do
    expect(current_path).to eq '/'
  end
end