class Hospital < ApplicationRecord
  has_many :doctors

  def doctor_names_with_patient_count
    doctors.joins(:patients).select("doctors.*, count(patient_doctors.id) as patient_count").order(patient_count: :desc).group("doctors.id")
  end
end
