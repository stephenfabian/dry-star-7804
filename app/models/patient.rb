class Patient < ApplicationRecord

  has_many :patient_doctors
  has_many :doctors, through: :patient_doctors


  def self.adult_patients_ordered_by_name
    # Patient.where("age > 18")
    # .order(:name)
    # .uniq

    Patient.where("age > 18")
    .order(:name).pluck(:name).uniq

  end

end