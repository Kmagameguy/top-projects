class Friendship < ApplicationRecord
  after_create :create_friend_relationship
  after_destroy :destroy_friend_relationship

  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user }
  validate :not_self

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  private

  def not_self
    errors.add(user.name, "can't be friends with themselves!") if user == friend
  end

  def create_friend_relationship
    friend.friendships.create(friend: user)
  end

  def destroy_friend_relationship
    friendship = friend.friendships.find_by(friend: user)
    friendship.destroy if friendship
  end
end
