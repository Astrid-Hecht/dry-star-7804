class Patient < ApplicationRecord
  has_many :doctor_patients, dependent: :destroy
  has_many :doctors, through: :doctor_patients
end
