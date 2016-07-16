class User < ActiveRecord::Base
  has_many :links
  validates :username, :description, presence: true
  validates :username, length: {maximum: 25}
end
