class ImportFile < ApplicationRecord
  belongs_to :user
  has_one_attached :file
  validates :status, presence: true
  validate :file_type_validation

  private
  
  def file_type_validation
    valid_types = ["text/csv"]
    if file.attached? && !file.content_type.in?(valid_types)
      errors.add(:file, "must be a CSV file.")
    end
  end
end
