require 'rails_helper'

RSpec.describe Patient do
  it {should have_many :doctor_patients}
  it {should have_many(:doctors).through(:doctor_patients) }

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
    describe '#list_adults_alpha' do
      it 'should only return patients above 18' do
        expect(Patient.list_adults_alpha.include?(ken)).to be(true)
        expect(Patient.list_adults_alpha.include?(jordie)).to be(true)
        expect(Patient.list_adults_alpha.include?(neil)).to be(true)
        expect(Patient.list_adults_alpha.include?(mary)).to be(false)
      end

      it 'should return them in alphabetical order' do
        expect(Patient.list_adults_alpha).to eq([jordie,ken,neil])
      end
    end
  end
end