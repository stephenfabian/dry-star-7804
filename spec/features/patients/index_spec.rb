require 'rails_helper'

RSpec.describe 'Patient Index Page' do
  describe 'User Story 3, Patient Index Page' do
    describe 'When I visit the patient index page' do
      describe 'I see the names of all adult patients (age is greater than 18)' do
        it 'And I see the names are in ascending alphabetical order (A - Z, you do not need to account for capitalization)' do

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

          visit patients_path
          
          expect(page).to have_content("Patient Index Page")
          expect(patient3.name).to appear_before(patient1.name)
          expect(page).to_not have_content(patient2.name)

        end
      end
    end
  end
end