class FriendRequest < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user }
  validate  :not_self

  private

  def not_self
    errors.add(:friend, "Can't be friends with themselves!") if user == friend
  end
end
