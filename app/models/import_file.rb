class ImportFile < ApplicationRecord
  require 'csv'
  require 'credit_card_validations/string'

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
  validates_size_of :file, maximum: 5.megabytes, message: "should be less than 5MB"
  validate :file_type_validation
  attr_accessor :column
  has_many :failed_registers
  
  def processing
    update_status!("processing")
    hash = read_csv_file
    value = hash[:status]
    update_status!(value)
  end

  #private
  
  def file_type_validation
    valid_types = ["text/csv"]
    if file.attached? && !file.content_type.in?(valid_types)
      errors.add(:file, "must be a CSV file.")
    end
  end

  def update_status!(status)
    self.status = status
    self.save
  end

  def read_csv_file
    imported_count = 0
    line = 0
    headers_failed = false
    tempfile = file.download
    CSV.parse(tempfile, headers: true) do |row|
      if line == 0
        unless has_valid_headers?(row.headers)
          set_failed_register("Wrong headers")
          headers_failed = true
          break
        end
      end
      line += 1;
      contact_attributes = get_contact_attributes(row)
      contact = Contact.new(contact_attributes)
      contact.user = user
      if user.contacts.find_by(email: contact.email)
        set_failed_register("Line #{line} - There is already a contact with that email")
        next
      end
      if contact.save
        imported_count += 1
      else
        set_failed_register("Line #{line} - #{contact.errors.full_messages.join(', ')}")
      end
    end
    if headers_failed || (imported_count == 0 && line != 0)
      return { status: "failed" }
    else
      return { status: "finished" }
    end
  end

  def get_contact_attributes(row)
    contact_attributes = {}
    column.each do |key, value|
      contact_attributes[key.to_sym] = row[value]
    end
    franchise_hash = get_franchise(contact_attributes)
    contact_attributes[:credit_card] = encrypt_cc(contact_attributes[:credit_card])
    contact_attributes.merge(franchise_hash)
  end

  def get_franchise(attributes)
    CreditCardValidations.add_brand(:discover, {length: 16, prefixes: '6011'})
    { franchise: attributes[:credit_card].credit_card_brand_name }
  end

  def set_failed_register(message)
    register = FailedRegister.new(error: message, import_file: self)
    register.save
  end

  def has_valid_headers?(headers)
    column.values.each do |value|
      return false unless headers.include?(value)
    end
    true
  end

  def encrypt_cc(cc)
    '*' * (cc.length - 4) + cc[-4, 4]
  end
end
