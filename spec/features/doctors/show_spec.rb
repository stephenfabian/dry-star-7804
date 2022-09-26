require 'rails_helper'

RSpec.describe 'User Story 1, Doctors Show Page' do
  describe 'When I visit a doctors show page' do
    describe 'I  see all of that doctors information including: name, specialty, university where they got their doctorate' do
      describe 'And I see the name of the hospital where this doctor works' do
        it 'And I see the names of all of the patients this doctor has' do

          hospital1 = Hospital.create!(name: "Stephen's Hospital")
          hospital2 = Hospital.create!(name: "Turing Hospital")

          doctor1 = hospital1.doctors.create!(name: "Roger", specialty: "brain surgery", university: "Baylor")
          doctor2 = hospital1.doctors.create!(name: "Jessie", specialty: "family practice", university: "MSU")
          doctor3 = hospital2.doctors.create!(name: "Phil", specialty: "urgent care", university: "Wisconsin")

          patient1 = Patient.create!(name: "Cam", age: 17)
          patient2 = Patient.create!(name: "Ethan", age: 17)
          patient3 = Patient.create!(name: "Billy", age: 15)

          doctor1.patient_doctors.create!(patient_id: patient1.id)
          doctor1.patient_doctors.create!(patient_id: patient2.id)
          doctor2.patient_doctors.create!(patient_id: patient3.id)

          visit doctor_path(doctor1)

          expect(page).to have_content(doctor1.name)
          expect(page).to have_content(doctor1.specialty)
          expect(page).to have_content(doctor1.university)
          expect(page).to have_content(hospital1.name)
          expect(page).to have_content(patient1.name)
          expect(page).to have_content(patient2.name)

        end
      end
    end
  end


  describe 'User Story 2, Remove a Patient from a Doctor' do
    describe 'When I visit a Doctors show page Next to each patients name, I see a button to remove that patient from that doctors caseload' do
      describe 'When I click that button for one patient' do
        describe 'Im brought back to the Doctors show page' do
          it 'And I no longer see that patients name listed' do

            hospital1 = Hospital.create!(name: "Stephen's Hospital")
            hospital2 = Hospital.create!(name: "Turing Hospital")

            doctor1 = hospital1.doctors.create!(name: "Roger", specialty: "brain surgery", university: "Baylor")
            doctor2 = hospital1.doctors.create!(name: "Jessie", specialty: "family practice", university: "MSU")
            doctor3 = hospital2.doctors.create!(name: "Phil", specialty: "urgent care", university: "Wisconsin")

            patient1 = Patient.create!(name: "Cam", age: 17)
            patient2 = Patient.create!(name: "Ethan", age: 17)
            patient3 = Patient.create!(name: "Billy", age: 15)

            doctor1.patient_doctors.create!(patient_id: patient1.id)
            doctor1.patient_doctors.create!(patient_id: patient2.id)
            doctor2.patient_doctors.create!(patient_id: patient3.id)

            visit doctor_path(doctor1)
            expect(page).to have_content(patient1.name)
            
            within("#patient_#{patient1.id}") do
              click_link("Remove #{patient1.name} from #{doctor1.name}'s caseload")
            end
            
            within("#patient_#{patient2.id}") do
              click_link("Remove #{patient2.name} from #{doctor1.name}'s caseload")
            end
        
            expect(current_path).to eq(doctor_path(doctor1))
            expect(page).to_not have_content(patient1.name)

          end
        end
      end
    end
  end
end