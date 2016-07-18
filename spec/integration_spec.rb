require('capybara/rspec')
require('./app')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)


describe('view stylists page', {:type => :feature}) do
  it('allows a user to view all stylists') do
    visit('/')
    click_on("View Stylists")
    expect(page).to have_content("Stylists")
  end
end

describe('add a stylist', {:type => :feature}) do
  it('allows a user to add a stylists') do
    visit('/stylists')
    click_on("Add Stylists")
    fill_in("name", :with => "John")
    fill_in("station", :with => 3)
    click_button("Submit")
    expect(page).to have_content("Hairs not Scares")
  end
end

describe('edit a stylist', {:type => :feature}) do
  it('allows a user to add a stylists') do
    visit('/stylists')
    click_on("Add Stylists")
    fill_in("name", :with => "John")
    fill_in("station", :with => 3)
    click_button("Submit")
    expect(page).to have_content("Hairs not Scares")
    click_on("John")
    click_on("Edit Stylist")
    expect(page).to have_content()
  end
end

describe('edit a stylist', {:type => :feature}) do
  it('allows a user to add a stylists') do
    visit('/stylists')
    click_on("Add Stylists")
    fill_in("name", :with => "John")
    fill_in("station", :with => 3)
    click_button("Submit")
    expect(page).to have_content("Hairs not Scares")
    click_on("John")
    click_on("Edit Stylist")
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
    fill_in("next_appointment", :with => "9999-99-99")
    click_button("Submit")
  end
end
