class User < ApplicationRecord
  has_many :followee_relationships, class_name: 'Relationship', foreign_key: :follower_id
  has_many :follower_relationships, class_name: 'Relationship', foreign_key: :followee_id
  has_many :followees, through: :followee_relationships
  has_many :followers, through: :follower_relationships
  has_many :trips
  has_many :reviews
end
