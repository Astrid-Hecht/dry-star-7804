require 'rails_helper'

RSpec.describe 'Doctor show page', type: :feature do
  describe "As a visitor When I visit a doctor's show page" do

    let!(:last_light) {Hospital.create!(name:'Last Light of Baleros')}
    let!(:shh) {Hospital.create!(name:'Sacred Heart Hospital')}

    let!(:geneva) {last_light.doctors.create!(name: 'Dr. Geneva', specialty: 'Trauma', univeristy: 'Some School State')}
    let!(:house) {last_light.doctors.create!(name: 'House MD', specialty: 'Who knows', univeristy: 'Some Other State')}
    let!(:braff) {shh.doctors.create!(name: 'Snack Braff', specialty: 'Wrestling', univeristy: 'WV School of Medical Dance')}

    let!(:ken) {geneva.patients.create!(name: 'Ken', age: 22)}
    let!(:jordie) {geneva.patients.create!(name: 'Jordie', age: 22)}
    let!(:neil) {house.patients.create!(name: 'Neil', age: 75)}
    let!(:mary) {braff.patients.create!(name: 'Mary', age: 47)}


    before(:each) do
      visit doctor_path(geneva)
    end

    it 'I see all their information' do
      within '#dr-info' do
        within '#dr-name' do
          expect(page).to have_content(geneva.name)
          expect(page).to_not have_content(house.name)
          expect(page).to_not have_content(braff.name)
        end

        within '#dr-specialty' do
          expect(page).to have_content(geneva.specialty)
          expect(page).to_not have_content(house.specialty)
          expect(page).to_not have_content(braff.specialty)
        end

        within '#dr-uni' do
          expect(page).to have_content(geneva.univeristy)
          expect(page).to_not have_content(house.univeristy)
          expect(page).to_not have_content(braff.univeristy)
        end
      end
    end

    it 'And I see the name of the hospital where this doctor works' do
      within '#dr-hospital' do
        expect(page).to have_content(last_light.name)
        expect(page).to_not have_content(shh.name)
      end
    end

    it 'And I see the names of all of the patients this doctor has' do
      within '#patients-list' do
        expect(page).to have_content("Name: #{ken.name} - #{ken.age} years old")
        expect(page).to have_content("Name: #{jordie.name} - #{jordie.age} years old")
        expect(page).to_not have_content("Name: #{neil.name} - #{neil.age} years old")
        expect(page).to_not have_content("Name: #{mary.name} - #{mary.age} years old")
      end
    end
  end
end