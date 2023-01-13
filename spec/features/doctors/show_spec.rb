require 'rails_helper'

RSpec.describe 'doctor show page' do
  before :each do
    @hospital = Hospital.create!(name: "Sacred Heart")

    @doctor = Doctor.create!(name: "Stan", specialty: "Cardiology", university: "U of R", hospital_id: @hospital.id)

    @patient_1 = Patient.create!(name: "Steve")
    @patient_2 = Patient.create!(name: "Justin")

    DoctorPatient.create!(doctor_id: @doctor.id, patient_id: @patient_1.id)
    DoctorPatient.create!(doctor_id: @doctor.id, patient_id: @patient_2.id)
  end
  it 'shows all of the doctors attributes' do
    visit doctor_path(@doctor)

    expect(page).to have_content(@doctor.name)
    expect(page).to have_content(@doctor.specialty)
    expect(page).to have_content(@doctor.university)
  end

  it 'shows the doctors patients' do
    visit doctor_path(@doctor)

    within("#patients") do
      expect(page).to have_content(@patient_1.name)
      expect(page).to have_content(@patient_2.name)
    end
  end

  it 'shows the hospital the doctor works at' do
    visit doctor_path(@doctor)

    within("#hospital") do
      expect(page).to have_content(@doctor.hospital.name)
    end
  end

  it 'can delete a patient' do
    visit doctor_path(@doctor)

    within("#patients") do
      expect(page).to have_content(@patient_1.name)

      expect(page).to have_button("Delete Steve")

      click_button "Delete Steve"

      expect(current_path).to eq(doctor_path(@doctor))

      expect(page).to_not have_content(@patient_1.name)
    end
  end
end