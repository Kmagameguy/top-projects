class User < ApplicationRecord
  has_many :posts
  has_many :comments

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 1 }
end
