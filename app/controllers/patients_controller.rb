class PatientsController < ApplicationController
  def index
    @patients = Patient.list_adults_alpha
  end
end