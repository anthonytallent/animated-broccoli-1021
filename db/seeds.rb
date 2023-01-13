# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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