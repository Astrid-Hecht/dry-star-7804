class Patient < ApplicationRecord
  has_many :doctor_patients, dependent: :destroy
  has_many :doctors, through: :doctor_patients

  def self.list_adults_alpha
    where('age >= ?', 18).order(:name)
  end
end
