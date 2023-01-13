require 'rails_helper'

RSpec.describe Patient do
  it {should have_many :doctor_patients}
  it {should have_many(:doctors).through(:doctor_patients)}

  describe "#adult_patients" do
    it "returns all patients over 18 in alphabetical order" do
      @hospital = Hospital.create!(name: "Sacred Heart")

      @doctor_1 = Doctor.create!(name: "Stan", specialty: "Cardiology", university: "U of R", hospital_id: @hospital.id)
      @doctor_2 = Doctor.create!(name: "Jeff", specialty: "Cardiology", university: "U of R", hospital_id: @hospital.id)
  
      @patient_1 = Patient.create!(name: "Steve", age: 42)
      @patient_2 = Patient.create!(name: "Justin", age: 28)
      @patient_3 = Patient.create!(name: "Joey", age: 15)
      @patient_4 = Patient.create!(name: "Brian", age: 22)
  
      DoctorPatient.create!(doctor_id: @doctor_1.id, patient_id: @patient_1.id)
      DoctorPatient.create!(doctor_id: @doctor_1.id, patient_id: @patient_2.id)
      DoctorPatient.create!(doctor_id: @doctor_2.id, patient_id: @patient_1.id)
      DoctorPatient.create!(doctor_id: @doctor_2.id, patient_id: @patient_2.id)
      DoctorPatient.create!(doctor_id: @doctor_2.id, patient_id: @patient_3.id)
      DoctorPatient.create!(doctor_id: @doctor_2.id, patient_id: @patient_4.id)

      expect(Patient.adult_patients).to eq([@patient_4, @patient_2, @patient_1])
    end
  end
end