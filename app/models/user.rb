class User < ApplicationRecord
  has_many :comments
  has_many :posts
  has_one :role
end
