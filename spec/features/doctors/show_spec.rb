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
          expect(page).to have_content(geneva.university)
          expect(page).to_not have_content(house.university)
          expect(page).to_not have_content(braff.university)
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

    describe 'Doctor Delete' do
      it "Next to each patient's name, I see a button to remove that patient from that doctor's caseload" do
        within '#patient-list' do 
          geneva.patients.each do |patient|
            within "#patient-#{patient.id}" do
              expect(page).to have_button("Remove from Caseload")
            end
          end
        end
      end

      it "When I click that button for one patient I'm brought back to the Doctor's show page"
        within '#patient-list' do 
          within "#patient-#{ken.id}" do
            expect(page).to have_content("Name: #{ken.name} - #{ken.age} years old")
            click_button("Remove from Caseload")
          end
        end
        expect(current_path).to eq(doctor_path(geneva))
        expect(page).to_not have_content("Name: #{ken.name} - #{ken.age} years old")
      end
    end
  end
end