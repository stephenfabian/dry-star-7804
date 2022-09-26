class HospitalsController < ApplicationController

  def show
    @hospital = Hospital.find(params[:id])
    @doctors_with_patient_count = @hospital.doctor_names_with_patient_count
  end
end