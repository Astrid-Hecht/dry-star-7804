class Doctor < ApplicationRecord
  belongs_to :hospital
  has_many :doctor_patients
  has_many :patients, through: :doctor_patients

  def self.sort_by_patients
    Doctor.group(:id).order('patients.count DESC')
  end
  
  def patient_count
    patients.count
  end
end
