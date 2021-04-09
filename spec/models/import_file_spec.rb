require 'rails_helper'

RSpec.describe ImportFile, type: :model do
  describe '#validations' do
    let(:user) { create(:user) }
    let(:import_file) { build(:import_file, user: user) }
    it 'test that is invalid' do
      aggregate_failures do
        import_file.status = ''
        import_file.user = nil
        expect(import_file).not_to be_valid
        expect(import_file.errors[:user]).to include('must exist')
        expect(import_file.errors[:status]).to include("can't be blank")
      end
    end

    it 'test that check if is valid' do
      expect(import_file).to be_valid
    end

    it 'test that import_file has a valid attached file' do
      aggregate_failures do
        expect(import_file.file).to be_attached
        expect(import_file).to be_valid
      end
    end

    it 'test that check if is invalid type attached file' do
      import_file.file.attach(io: File.open(Rails.root.join('tmp', 'storage', 'gatsby.png')),
                              filename: 'gatsby.png')
      expect(import_file).not_to be_valid
    end
  end
end
