class ImportFile < ApplicationRecord
  enum status_options: {
    on_hold: "on hold",
    processing: "processing",
    failed: "failed",
    finished: "finished",
    }, _prefix: :status
  belongs_to :user
  has_one_attached :file
  validates :status, presence: true,
            inclusion: {
              in: status_options.values,
              message: "%{value} is not a valid status"
            }
  validate :file_type_validation

  private
  
  def file_type_validation
    valid_types = ["text/csv"]
    if file.attached? && !file.content_type.in?(valid_types)
      errors.add(:file, "must be a CSV file.")
    end
  end
end
