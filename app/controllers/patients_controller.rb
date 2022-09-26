class PatientsController < ApplicationController

  def update
    @doctor = Doctor.find(params[:doctor_id])
    @patient = Patient.find(params[:id])
    @patient.update!(enabled: false)
    redirect_to doctor_path(@doctor)
  end
end