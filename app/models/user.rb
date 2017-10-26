class User < ApplicationRecord
  EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\z/

  attr_accessor :image_file

  validates :email, presence: true, format: { with: EMAIL_REGEX }
  validates :image, presence: true
end
