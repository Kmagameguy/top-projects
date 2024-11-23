class Post < ApplicationRecord
  validates :body, presence: true
  validates :user_id, presence: true

  belongs_to :author, class_name: "User", foreign_key: :user_id

  default_scope { order(created_at: :desc) }
end
