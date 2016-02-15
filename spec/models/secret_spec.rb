
require 'rails_helper'
RSpec.describe Secret, type: :model do
  it 'requires content' do
    secret = Secret.new
    secret.valid?
    expect(secret.errors[:content].any?).to eq(true)
  end
  describe 'relationships' do
    it 'belongs to a user' do
      user = create_user
      secret = user.secrets.create(content: 'secret 1')
      expect(secret.user).to eq(user)
    end
    it 'has many likes' do
      user1 = create_user
      user2 = create_user 'julius', 'julius@lakers.com'
      secret = user1.secrets.create(content: 'secret 1')
      like1 = Like.create(user: user1, secret: secret)
      like2 = Like.create(user: user2, secret: secret)
      expect(secret.likes).to include(like1)
      expect(secret.likes).to include(like2)
    end
  end
end
