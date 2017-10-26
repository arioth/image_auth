require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should allow_value('john.doe@stark.com').for(:email) }
  it { should allow_value('john.doe@stark.com.ve').for(:email) }
  it { should_not allow_value('john.doe.stark.com').for(:email) }
  it { should validate_presence_of(:image) }

  describe '#convert_image_file' do
    let(:user) { create(:user) }

    it 'does nothing if image_file is empty' do
      previous_image = user.image
      user.convert_image_file
      expect(user.image).to eq(previous_image)
    end

    it 'encode the image to base64' do
      previous_image = user.image
      tempfile = Tempfile.new
      user.image_file = ActionDispatch::Http::UploadedFile.new tempfile: tempfile
      user.convert_image_file
      expect(user.image).to_not eq(previous_image)
    end
  end
end
