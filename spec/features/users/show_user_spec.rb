require 'rails_helper'
RSpec.describe 'user profile page' do
  before do
    @user = create_user
    log_in @user
  end
  it 'displays information about the user' do
    expect(page).to have_text("#{@user.name}")
    expect(page).to have_link('Edit Profile')
  end
end
