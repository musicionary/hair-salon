require('capybara/rspec')
require('./app')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)


describe('adding a new stylist', {:type => :feature}) do
  it('allows a user to add a stylist') do
    visit('/')
    click_on("View Stylists")
    expect(page).to have_content("Stylists")
    click_on("Add Stylists")
    fill_in("name", :with => "John")
    fill_in("station", :with => 3)
    click_button("Submit")
    expect(page).to have_content("Hairs not Scares")
  end
end

describe('adding a new client', {:type => :feature}) do
  it('allows a user to add a client') do
    visit('/')
    click_on("View Stylists")
    expect(page).to have_content("Stylists")
    click_on("Add Stylists")
    fill_in("name", :with => "John")
    fill_in("station", :with => 3)
    click_button("Submit")
    expect(page).to have_content("Hairs not Scares")
    click_on("John")
    expect(page).to have_content("John")
    click_on("Add a Client")
    fill_in("name", :with => "James")
    fill_in("next_appointment", :with => "9999-99-99 00:00:00")
    click_button("Submit")
  end
end
