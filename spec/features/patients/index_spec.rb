require 'rails_helper'

RSpec.describe 'Doctor show page', type: :feature do
  describe "As a visitor When I visit a doctor's show page" do

    let!(:last_light) {Hospital.create!(name:'Last Light of Baleros')}
    let!(:shh) {Hospital.create!(name:'Sacred Heart Hospital')}

    let!(:geneva) {last_light.doctors.create!(name: 'Dr. Geneva', specialty: 'Trauma', university: 'Some School State')}
    let!(:house) {last_light.doctors.create!(name: 'House MD', specialty: 'Who knows', university: 'Some Other State')}
    let!(:braff) {shh.doctors.create!(name: 'Snack Braff', specialty: 'Wrestling', university: 'WV School of Medical Dance')}

    let!(:ken) {geneva.patients.create!(name: 'Ken', age: 22)}
    let!(:jordie) {geneva.patients.create!(name: 'Jordie', age: 22)}
    let!(:neil) {house.patients.create!(name: 'Neil', age: 75)}
    let!(:mary) {braff.patients.create!(name: 'Mary', age: 17)}


    before(:each) do
      visit patients_path
    end

    it 'I see the names of all adult patients (age is greater than 18)' do
      within '#patient-list' do
        expect(page).to have_content(ken.name)
        expect(page).to have_content(jordie.name)
        expect(page).to have_content(neil.name)
        expect(page).to_not have_content(mary.name)
      end
    end

    it 'And I see the names are in ascending alphabetical order' do
      expect(jordie.name).to appear_before(ken.name)
      expect(ken.name).to appear_before(neil.name)
    end

  end
end