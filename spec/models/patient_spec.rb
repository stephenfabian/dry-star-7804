require 'rails_helper'

RSpec.describe Patient do

  it {should have_many :doctors}
  it {should have_many(:doctors).through(:patient_doctors)}

  it 'adult_patients_ordered_by_name' do
    hospital1 = Hospital.create!(name: "Stephen's Hospital")
    hospital2 = Hospital.create!(name: "Turing Hospital")

    doctor1 = hospital1.doctors.create!(name: "Roger", specialty: "brain surgery", university: "Baylor")
    doctor2 = hospital1.doctors.create!(name: "Jessie", specialty: "family practice", university: "MSU")
    doctor3 = hospital2.doctors.create!(name: "Phil", specialty: "urgent care", university: "Wisconsin")

    patient1 = Patient.create!(name: "Cam", age: 20)
    patient2 = Patient.create!(name: "Ethan", age: 17)
    patient3 = Patient.create!(name: "Billy", age: 19)

    doctor1.patient_doctors.create!(patient_id: patient1.id)
    doctor1.patient_doctors.create!(patient_id: patient2.id)
    doctor2.patient_doctors.create!(patient_id: patient3.id)

    expect(Patient.adult_patients_ordered_by_name).to eq(["Billy", "Cam"])
  end

end