require('sinatra')
require('sinatra/reloader')
also_reload("lib/**/*.rb")
require('./lib/location')
require('./lib/stylist')
require('./lib/client')
require('pg')
require('pry')

# DB = PG.connect({:dbname => "hair_salon"})

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
  # @cities = City.all()
  erb(:location)
end

get("/locations/:id/edit") do
  @location = Location.find(params.fetch("id").to_i())
  # @cities = City.all()
  erb(:location_edit)
end

patch("/locations/:id") do
  # @cities = City.all()
  location_id = params.fetch("id").to_i()
  @location = Location.find(location_id)
  if params.fetch('store_name') == ""
    store_name = @location.store_name()
  else
    store_name = params.fetch('store_name').to_i()
  end
  if params.fetch('street') == ""
    street = @location.street()
  else
    street = params.fetch('street').to_i()
  end
  if params.fetch('city') == ""
    city = @location.city()
  else
    city = params.fetch('city').to_i()
  end
  if params.fetch('zip') == ""
    zip = @location.zip()
  else
    zip = params.fetch('zip').to_i()
  end
  if params.fetch('opening_time') == ""
    opening_time = @location.opening_time()
  else
    opening_time = params.fetch('opening_time').to_i()
  end
  if params.fetch('closing_time') == ""
    closing_time = @location.closing_time()
  else
    closing_time = params.fetch('closing_time').to_i()
  end
  # city_ids = params.fetch("city_ids", [])
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
  # @cities = City.all()
  erb(:stylist)
end



#######################################
# CLIENTS
#######################################

get('/clients') do
  @clients = Client.all()
  erb(:clients)
end

get('/clients/new') do
  erb(:client_form)
end

post('/clients') do
  name = params.fetch('name')
  next_appointment = params.fetch('next_appointment')

  client = Client.new({name: name, next_appointment: next_appointment, stylist_id: 1})
  client.save()
  @clients = Client.all()
  erb(:clients)
end

get('/clients/:id') do
  @client = Client.find(params.fetch('id').to_i())
  # @cities = City.all()
  erb(:client)
end
