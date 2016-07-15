require('sinatra')
require('sinatra/reloader')
also_reload("lib/**/*.rb")
require('./lib/location')
require('./lib/stylist')
require('./lib/client')
require('pg')
require('pry')

DB = PG.connect({:dbname => "hair_salon"})

get("/") do
  erb(:index)
end

get('/locations') do
  @locations = Location.all()
  erb(:locations)
end

get('/locations/new') do
  erb(:location_form)
end

post('/locations') do
  store_name = params.fetch('store_name')
  street = params.fetch('street')
  city = params.fetch('city')
  zip = params.fetch('zip')
  opening_time = params.fetch('opening_time')
  closing_time = params.fetch('closing_time')

  location = Location.new({store_name: store_name, street: street, city: city, zip: zip, opening_time: opening_time, closing_time: closing_time})
  location.save()
  @locations = Location.all()
  erb(:locations)
end

get('/locations/:id') do
  @location = Location.find(params.fetch('id').to_i())
  erb(:location)
end

get("/locations/:id/edit") do
  @location = Location.find(params.fetch("id").to_i())
  erb(:location_edit)
end

patch("/locations/:id") do
  location_id = params.fetch("id").to_i()
  @location = Location.find(location_id)
  if params.fetch('store_name') == ""
    store_name = @location.store_name()
  else
    store_name = params.fetch('store_name')
  end
  if params.fetch('street') == ""
    street = @location.street()
  else
    street = params.fetch('street')
  end
  if params.fetch('city') == ""
    city = @location.city()
  else
    city = params.fetch('city')
  end
  if params.fetch('zip') == ""
    zip = @location.zip()
  else
    zip = params.fetch('zip')
  end
  if params.fetch('opening_time') == ""
    opening_time = @location.opening_time()
  else
    opening_time = params.fetch('opening_time')
  end
  if params.fetch('closing_time') == ""
    closing_time = @location.closing_time()
  else
    closing_time = params.fetch('closing_time')
  end
  @location.update({store_name: store_name, street: street, city: city, zip: zip, opening_time: opening_time, closing_time: closing_time})
  erb(:location)
end

delete("/locations/:id") do
  @location = Location.find(params.fetch("id").to_i())
  @location.delete()
  @locations = Location.all()
  erb(:locations)
end


#######################################
# STYLISTS
#######################################
get('/stylists') do
  @stylists = Stylist.all()
  erb(:stylists)
end

get('/stylists/new') do
  erb(:stylist_form)
end

post('/stylists') do
  name = params.fetch('name')
  station = params.fetch('station')

  stylist = Stylist.new({name: name, station: station, location_id: 1})
  stylist.save()
  @stylists = Stylist.all()
  erb(:stylists)
end

get('/stylists/:id') do
  @stylist = Stylist.find(params.fetch('id').to_i())
  erb(:stylist)
end

get("/stylists/:id/edit") do
  @stylist = Stylist.find(params.fetch("id").to_i())
  erb(:stylist_edit)
end

patch("/stylists/:id") do
  stylist_id = params.fetch("id").to_i()
  @stylist = Stylist.find(stylist_id)
  if params.fetch('name') == ""
    name = @stylist.name()
  else
    name = params.fetch('name')
  end
  if params.fetch('station') == ""
    station = @stylist.station()
  else
    station = params.fetch('station').to_i()
  end
  @stylist.update({name: name, station: station, client_ids: client_ids})
  erb(:stylist)
end

delete("/stylists/:id") do
  @stylist = Stylist.find(params.fetch("id").to_i())
  @stylist.delete()
  @stylists = Stylist.all()
  erb(:stylists)
end

get("/stylists/:id/client/new") do
  @stylist = Stylist.find(params.fetch("id").to_i())
  erb(:client_form)
end


get('/clients') do
  @clients = Client.all()
  erb(:clients)
end

post('/clients') do
  name = params.fetch('name')
  next_appointment = params.fetch('next_appointment')
  stylist_id = params.fetch("stylist_id").to_i()
  @stylist = Stylist.find(stylist_id)
  @client = Client.new({name: name, next_appointment: next_appointment, stylist_id: stylist_id})
  @client.save()
  @clients = Client.all()
  erb(:clients)
end

get("/stylists/:id/client/:id1") do
  @stylist = Stylist.find(params.fetch("id").to_i())
  @client = Client.find(params.fetch("id1").to_i())
  erb(:client)
end

get("/clients/:id/edit") do
  @client = Client.find(params.fetch("id").to_i())
  erb(:client_edit)
end

patch("/clients/:id") do
  client_id = params.fetch("id").to_i()
  @client = Client.find(client_id)
  if params.fetch('name') == ""
    name = @client.name()
  else
    name = params.fetch('name')
  end
  if params.fetch('next_appointment') == ""
    next_appointment = @client.next_appointment()
  else
    next_appointment = params.fetch('next_appointment')
  end
  @client.update({name: name, next_appointment: next_appointment})
  erb(:client)
end

delete("/clients/:id") do
  @client = Client.find(params.fetch("id").to_i())
  @client.delete()
  @clients = Client.all()
  erb(:clients)
end
