class Friendship < ApplicationRecord
  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user }
  validate :not_self

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  private

  def not_self
    errors.add(user.name, "can't be friends with themselves!") if user == friend
  end
end
