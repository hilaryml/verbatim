class Post < ApplicationRecord
  has_many :post_users
  has_many :users, through: :post_users
  validates :content, presence: true
end
