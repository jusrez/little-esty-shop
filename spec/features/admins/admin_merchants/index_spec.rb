require 'rails_helper'

RSpec.describe 'the admin_merchants index' do
  it 'shows the names of all of the merchants' do
    merchant_1 = Merchant.create!(name: "Wizards Chest")
    merchant_2 = Merchant.create!(name: "Tattered Cover")
    merchant_3 = Merchant.create!(name: "Powell's City of Books")

    visit '/admin/merchants'
    expect(current_path).to eq('/admin/merchants')

    expect(page).to have_content("Wizards Chest")
    expect(page).to have_content("Tattered Cover")
    expect(page).to have_content("Powell's City of Books")
  end

  it 'has links to the merchants show page' do
    merchant_1 = Merchant.create!(name: "Wizards Chest")
    merchant_2 = Merchant.create!(name: "Tattered Cover")
    merchant_3 = Merchant.create!(name: "Powell's City of Books")

    visit '/admin/merchants'

    expect(page).to have_link("Wizards Chest")
    expect(page).to have_link("Tattered Cover")
    expect(page).to have_link("Powell's City of Books")

    click_link("Wizards Chest")
    expect(current_path).to eq("/admin/merchants/#{merchant_1.id}")

    expect(page).to have_content("Wizards Chest")
    expect(page).to_not have_content("Powell's City of Books")
  end

  it 'shows status' do
    merchant_1 = Merchant.create!(name: "Wizards Chest")
    merchant_2 = Merchant.create!(name: "Tattered Cover", status: "disabled")

    visit '/admin/merchants'

    within "#merchant-#{merchant_1.id}" do
      expect(page).to have_content("Status: enabled")
    end

    within "#merchant-#{merchant_2.id}" do
      expect(page).to have_content("Status: disabled")
    end
  end

  it "has button to enable/disable status" do
    merchant_1 = Merchant.create!(name: "Wizards Chest", status: "disabled")
    merchant_2 = Merchant.create!(name: "Tattered Cover")

    visit '/admin/merchants'

    within "#merchant-#{merchant_1.id}" do
      expect(page).to have_button("Enable #{merchant_1.name}")
      expect(page).to_not have_button("Disable #{merchant_1.name}")
    end

    within "#merchant-#{merchant_2.id}" do
      expect(page).to have_button("Disable #{merchant_2.name}")
      expect(page).to_not have_button("Enable #{merchant_2.name}")
    end
  end

  it "clicking button changes status" do
    merchant_1 = Merchant.create!(name: "Wizards Chest", status: "disabled")

    visit '/admin/merchants'

    within "#merchant-#{merchant_1.id}" do
      expect(page).to have_button("Enable #{merchant_1.name}")
      expect(page).to have_content("Status: disabled")
    end

    click_button("Enable #{merchant_1.name}")
    expect(current_path).to eq('/admin/merchants')

    within "#merchant-#{merchant_1.id}" do
      expect(page).to have_button("Disable #{merchant_1.name}")
      expect(page).to have_content("Status: enabled")
    end
  end
# As an admin,
# When I visit the admin merchants index
# Then next to each merchant name I see a button to disable or enable that merchant.
# When I click this button
# Then I am redirected back to the admin merchants index
# And I see that the merchant's status has changed
end