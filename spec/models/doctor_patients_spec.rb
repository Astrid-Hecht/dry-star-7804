require 'rails_helper'

RSpec.describe DoctorPatient do
  it {should belong_to :doctor}
  it {should belong_to :patient}

  let!(:last_light) {Hospital.create!(name:'Last Light of Baleros')}
  let!(:shh) {Hospital.create!(name:'Sacred Heart Hospital')}

  let!(:geneva) {last_light.doctors.create!(name: 'Dr. Geneva', specialty: 'Trauma', university: 'Some School State')}
  let!(:house) {last_light.doctors.create!(name: 'House MD', specialty: 'Who knows', university: 'Some Other State')}
  let!(:braff) {shh.doctors.create!(name: 'Snack Braff', specialty: 'Wrestling', university: 'WV School of Medical Dance')}

  let!(:ken) {geneva.patients.create!(name: 'Ken', age: 22)}
  let!(:jordie) {geneva.patients.create!(name: 'Jordie', age: 22)}
  let!(:neil) {house.patients.create!(name: 'Neil', age: 75)}
  let!(:mary) {braff.patients.create!(name: 'Mary', age: 17)}

  describe 'class methods' do 
    describe '#find_match' do
      it 'finds one doctorpatient relation obj' do
        expect(DoctorPatient.find_match(geneva.id, ken.id).count).to eq(1)
      end

      it 'finds the correct relation obj' do
        expect(DoctorPatient.find_match(geneva.id, ken.id)).to eq(DoctorPatient.where(doctor_id: geneva.id, patient_id: ken.id).first)
        expect(DoctorPatient.find_match(geneva.id, jordie.id)).to eq(DoctorPatient.where(doctor_id: geneva.id, patient_id: jordie.id ).first)
        expect(DoctorPatient.find_match(house.id, neil.id)).to eq(DoctorPatient.where(doctor_id: house.id, patient_id: neil.id).first)
        expect(DoctorPatient.find_match(braff.id, mary.id)).to eq(DoctorPatient.where(doctor_id: braff.id, patient_id: mary.id).first)
      end

      it 'returns nil if no relationship exists' do
        expect(DoctorPatient.find_match(geneva.id, mary.id)).to eq(nil)
      end
    end
  end
end