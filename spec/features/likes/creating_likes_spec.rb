require 'rails_helper'
RSpec.describe 'displaying likes' do
  before do
    @user = create_user
    log_in @user
    @user.secrets.create(content: 'Oops')
  end
  it 'creates like and displays it both in profile and secrets page' do
    visit '/secrets'
    expect(page).to have_text('0 likes')
    click_button 'Like'
    expect(current_path).to eq('/secrets')
    expect(page).to have_text('1 likes')
    visit "/users/#{@user.id}"
    expect(page).to have_text('1 likes')
  end
end
