class Post < ApplicationRecord
  validates :body, presence: true
  validates :user_id, presence: true

  belongs_to :author, class_name: "User", foreign_key: :user_id

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  default_scope { order(created_at: :desc) }
end
