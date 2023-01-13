require 'rails_helper'

RSpec.describe 'doctor show page' do
  before :each do
    @hospital = Hospital.create!(name: "Sacred Heart")

    @doctor_1 = Doctor.create!(name: "Stan", specialty: "Cardiology", university: "U of R", hospital_id: @hospital.id)
    @doctor_2 = Doctor.create!(name: "Jeff", specialty: "Cardiology", university: "U of R", hospital_id: @hospital.id)

    @patient_1 = Patient.create!(name: "Steve", age: 42)
    @patient_2 = Patient.create!(name: "Justin", age: 28)
    @patient_3 = Patient.create!(name: "Joey", age: 71)
    @patient_4 = Patient.create!(name: "Brian", age: 22)

    DoctorPatient.create!(doctor_id: @doctor_1.id, patient_id: @patient_1.id)
    DoctorPatient.create!(doctor_id: @doctor_1.id, patient_id: @patient_2.id)
    DoctorPatient.create!(doctor_id: @doctor_2.id, patient_id: @patient_1.id)
    DoctorPatient.create!(doctor_id: @doctor_2.id, patient_id: @patient_2.id)
    DoctorPatient.create!(doctor_id: @doctor_2.id, patient_id: @patient_3.id)
    DoctorPatient.create!(doctor_id: @doctor_2.id, patient_id: @patient_4.id)
  end
  it 'shows all of the doctors attributes' do
    visit doctor_path(@doctor_1)

    expect(page).to have_content(@doctor_1.name)
    expect(page).to have_content(@doctor_1.specialty)
    expect(page).to have_content(@doctor_1.university)
  end

  it 'shows the hospital the doctor works at' do
    visit doctor_path(@doctor_1)
    
    within("#hospital") do
      expect(page).to have_content(@doctor_1.hospital.name)
    end
  end
  
  it 'shows all of the doctors patients' do
    visit doctor_path(@doctor_1)

    within("#patients") do
      expect(page).to have_content(@patient_1.name)
      expect(page).to have_content(@patient_2.name)
    end
  end

  it 'can delete a patient from a specific doctor' do
    visit doctor_path(@doctor_1)

    within("#patients") do
      expect(page).to have_content(@patient_1.name)

      expect(page).to have_button("Delete Steve")

      click_button "Delete Steve"

      expect(current_path).to eq(doctor_path(@doctor_1))

      expect(page).to_not have_content(@patient_1.name)
    end

    visit doctor_path(@doctor_2)

    expect(page).to have_content("Steve")
  end
end