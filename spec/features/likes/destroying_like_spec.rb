require 'rails_helper'
RSpec.describe 'displaying likes' do
  before do
    @user = create_user
    log_in @user
    @secret1 = @user.secrets.create(content: 'Oops')
    @secret2 = @user.secrets.create(content: 'I did it again')
    Like.create(user: @user, secret: @secret1)
  end
  it 'displays unlike button for secrets already liked' do
    visit '/secrets'
    expect(page).to have_text(@secret1.content)
    expect(page).to have_text('1 likes')
    expect(page).to have_button('Unlike')
    expect(page).to have_text(@secret2.content)
    expect(page).to have_text('0 likes')
    expect(page).to have_button('Like')
  end
  it 'deletes like and displays the changes in both profile and secrets page' do
    visit '/secrets'
    click_button 'Unlike'
    expect(current_path).to eq("/secrets")
    expect(page).not_to have_button('Unlike')
    expect(page).not_to have_text('1 likes')
    visit "/users/#{@user.id}"
    expect(page).not_to have_text('1 likes')
  end
  it 'creates like and displays it both in profile and secrets page' do
    visit '/secrets'
    click_button 'Like'
    expect(current_path).to eq('/secrets')
    expect(page).not_to have_button('Like')
    expect(page).not_to have_text('0 likes')
    visit "/users/#{@user.id}"
    expect(page).not_to have_text('0 likes')
  end
end
