require 'rails_helper'

RSpec.describe 'logging in' do
  before do
    @user = create_user
  end

  it 'prompts for email and password' do
    visit '/sessions/new'

    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
  end

  it 'logs in user if email/password combination is valid' do
    log_in @user
    expect(current_path).to eq("/users/#{@user.id}")
    expect(page).to have_text(@user.name)
  end

  it 'does not sign in user if email/password combinattion is invalid' do
    log_in @user, 'wrong password'
    expect(page).to have_text('Invalid')
  end
end
