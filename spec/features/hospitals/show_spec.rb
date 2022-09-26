require 'rails_helper'

RSpec.describe 'Extension, Hospital Show Page' do
  describe 'When I visit a hospitals show page I see the hospitals name And I see the names of all doctors that work at this hospital' do
    describe 'next to each doctor I see the number of patients associated with the doctor' do
      it 'And I see the list of doctors is ordered from most number of patients to least number of patients' do

        hospital1 = Hospital.create!(name: "Stephen's Hospital")
        hospital2 = Hospital.create!(name: "Turing Hospital")

        doctor3 = hospital1.doctors.create!(name: "Phil", specialty: "urgent care", university: "Wisconsin")
        doctor1 = hospital1.doctors.create!(name: "Roger", specialty: "brain surgery", university: "Baylor")
        doctor2 = hospital1.doctors.create!(name: "Jessie", specialty: "family practice", university: "MSU")

        patient1 = Patient.create!(name: "Cam", age: 17)
        patient2 = Patient.create!(name: "Ethan", age: 17)
        patient3 = Patient.create!(name: "Billy", age: 15)
        patient4 = Patient.create!(name: "Tommy", age: 15)
        patient5 = Patient.create!(name: "Katie", age: 15)
        patient6 = Patient.create!(name: "Sue", age: 40)

        doctor1.patient_doctors.create!(patient_id: patient1.id)
        doctor1.patient_doctors.create!(patient_id: patient2.id)
        doctor2.patient_doctors.create!(patient_id: patient3.id)
        doctor3.patient_doctors.create!(patient_id: patient4.id)
        doctor3.patient_doctors.create!(patient_id: patient5.id)
        doctor3.patient_doctors.create!(patient_id: patient6.id)

        visit hospital_path(hospital1)

        expect(page).to have_content("#{hospital1.name} Show Page")
        expect("Doctor name: #{doctor1.name}, Patient count: #{doctor1.patients.count}").to appear_before("Doctor name: #{doctor2.name}, Patient count: #{doctor2.patients.count}")
        expect("Doctor name: #{doctor3.name}, Patient count: #{doctor3.patients.count}").to appear_before("Doctor name: #{doctor2.name}, Patient count: #{doctor2.patients.count}")
        expect("Doctor name: #{doctor3.name}, Patient count: #{doctor3.patients.count}").to appear_before("Doctor name: #{doctor1.name}, Patient count: #{doctor1.patients.count}")
 
      end
    end
  end
end
