require 'rails_helper'

RSpec.describe ImportFile, type: :model do
  describe 'ImportFile #validations' do
    let(:user) { create(:user) }
    let(:import_file) { build(:import_file, user: user) }
    it 'test that import_file object is invalid' do
      aggregate_failures do
        import_file.status = ''
        import_file.user = nil
        expect(import_file).not_to be_valid
        expect(import_file.errors[:user]).to include('must exist')
        expect(import_file.errors[:status]).to include("can't be blank")
      end
    end

    it 'test that import_file object is valid' do
      expect(import_file).to be_valid
    end

    it 'test that import_file has a valid attached file' do
      expect(import_file.file).to be_attached
    end
  end
end
