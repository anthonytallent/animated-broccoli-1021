require 'rails_helper'

RSpec.describe 'patient index page' do
  before :each do
    @hospital = Hospital.create!(name: "Sacred Heart")

    @doctor_1 = Doctor.create!(name: "Stan", specialty: "Cardiology", university: "U of R", hospital_id: @hospital.id)
    @doctor_2 = Doctor.create!(name: "Jeff", specialty: "Cardiology", university: "U of R", hospital_id: @hospital.id)

    @patient_2 = Patient.create!(name: "Justin", age: 28)
    @patient_1 = Patient.create!(name: "Steve", age: 42)
    @patient_3 = Patient.create!(name: "Joey", age: 15)
    @patient_4 = Patient.create!(name: "Brian", age: 22)

    DoctorPatient.create!(doctor_id: @doctor_1.id, patient_id: @patient_1.id)
    DoctorPatient.create!(doctor_id: @doctor_1.id, patient_id: @patient_2.id)
    DoctorPatient.create!(doctor_id: @doctor_2.id, patient_id: @patient_1.id)
    DoctorPatient.create!(doctor_id: @doctor_2.id, patient_id: @patient_2.id)
    DoctorPatient.create!(doctor_id: @doctor_2.id, patient_id: @patient_3.id)
    DoctorPatient.create!(doctor_id: @doctor_2.id, patient_id: @patient_4.id)
  end

  it 'has all patients ages greater than 18' do
    visit patients_path

    within("#adult_patients") do
      expect(page).to have_content(@patient_1.name)
      expect(page).to have_content(@patient_2.name)
      expect(page).to have_content(@patient_4.name)

      expect(page).to_not have_content(@patient_3.name)
    end
  end

  it 'will have the patients ordered alphabetically' do
    visit patients_path
    withing("#adult_patients") do
      expect(@patient_4.name).to appear_before(@patient_2.name)
      expect(@patient_2.name).to appear_before(@patient_1.name)
    end
  end
end