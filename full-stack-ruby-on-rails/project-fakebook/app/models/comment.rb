class Comment < ApplicationRecord
  validates :body, presence: true
  validates :user_id, presence: true
  validates :commentable_id, presence: true

  belongs_to :commentable, polymorphic: true
  belongs_to :author, class_name: "User", foreign_key: :user_id
end
