class User < ApplicationRecord
  EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\z/

  attr_accessor :image_file

  validates :email, presence: true, format: { with: EMAIL_REGEX }
  validates :image, presence: true

  before_validation :convert_image_file


  def convert_image_file
    return unless self.image_file.present?

    if self.image_file.is_a?(ActionDispatch::Http::UploadedFile) && self.image_file.tempfile
      self.image = Base64.encode64(image_file.tempfile.read)
    end
  end
end
