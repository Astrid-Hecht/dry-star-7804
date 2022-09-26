class DoctorsController < ApplicationController
  def show
    @doctor = Doctor.find(params[:id])
  end

  def destroy
    doctor = Doctor.find(params[:id])
    patient = Patient.find(params[:patient_id])
    DoctorPatient.find_match(doctor.id, patient.id).destroy
    redirect_to doctor_path(doctor)
  end
  
end
