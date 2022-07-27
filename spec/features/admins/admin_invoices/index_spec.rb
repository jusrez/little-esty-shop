require 'rails_helper'

RSpec.describe 'the admin_invoices index' do
  it 'shows all invoice ids and links to thier show pages' do
    customer_1 = Customer.create!(first_name: "A", last_name: "A")

    invoice_1 = Invoice.create!(status: "completed", customer_id: customer_1.id)
    invoice_2 = Invoice.create!(status: "completed", customer_id: customer_1.id)
    invoice_3 = Invoice.create!(status: "completed", customer_id: customer_1.id)

    visit '/admin/invoices'
    expect(current_path).to eq('/admin/invoices')

    expect(page).to have_link("Invoice #{invoice_1.id}")
    expect(page).to have_link("Invoice #{invoice_2.id}")
    expect(page).to have_link("Invoice #{invoice_3.id}")
    save_and_open_page

    click_link("Invoice #{invoice_1.id}")
    expect(current_path).to eq("/admin/invoices/#{invoice_1.id}")
  end
end
# As an admin,
# When I visit the admin Invoices index ("/admin/invoices")
# Then I see a list of all Invoice ids in the system
# Each id links to the admin invoice show page
