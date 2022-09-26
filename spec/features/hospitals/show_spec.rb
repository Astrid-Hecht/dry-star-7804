require 'rails_helper'

RSpec.describe 'Hospital show page', type: :feature do
  describe "As a visitor When I visit a hospital's show page" do

    let!(:last_light) {Hospital.create!(name:'Last Light of Baleros')}
    let!(:shh) {Hospital.create!(name:'Sacred Heart Hospital')}

    let!(:geneva) {last_light.doctors.create!(name: 'Dr. Geneva', specialty: 'Trauma', university: 'Some School State')}
    let!(:house) {last_light.doctors.create!(name: 'House MD', specialty: 'Who knows', university: 'Some Other State')}
    let!(:braff) {shh.doctors.create!(name: 'Snack Braff', specialty: 'Wrestling', university: 'WV School of Medical Dance')}
    
    
    let!(:ken) {geneva.patients.create!(name: 'Ken', age: 22)}
    let!(:jordie) {geneva.patients.create!(name: 'Jordie', age: 22)}
    let!(:neil) {house.patients.create!(name: 'Neil', age: 75)}
    let!(:mary) {braff.patients.create!(name: 'Mary', age: 47)}

    before(:each) do
      visit hospital_path(last_light)
    end

    it "I see the hospital's name" do
      within '#hospital-name' do
        expect(page).to have_content(last_light.name)
        expect(page).to_not have_content(shh.name)
      end
    end

    it 'And I see the names of all doctors that work at this hospital' do
      within '#staff' do
        expect(page).to have_content(geneva.name)
        expect(page).to have_content(house.name)
        expect(page).to_not have_content(braff.name)
      end
    end

    it 'And next to each doctor I see the number of patients associated with the doctor' do
      within '#staff' do
        last_light.doctors.each do |doctor|
          within "#doctor-#{doctor.id}" do
            expect(page).to have_content("Patient count - #{doctor.patient_count}")
          end
        end
      end
    end

    let!(:who) {last_light.doctors.create!(name: 'The Doctor', specialty: 'Chronic conditions', university: 'UG')}
    let!(:rose) {who.patients.create!(name: 'Rose', age: 22)}
    let!(:martha) {who.patients.create!(name: 'Martha', age: 22)}
    let!(:clara) {who.patients.create!(name: 'Clara', age: 22)}

    it "And I see the list of doctors is ordered from most number of patients to least number of patients" do
      within '#staff' do 
        expect(who.name).to appear_before(geneva.name)
        expect(geneva.name).to appear_before(house.name)
      end
    end
  end
end