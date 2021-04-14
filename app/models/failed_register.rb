class FailedRegister < ApplicationRecord
  belongs_to :import_file
  validates :error, presence: true
end
