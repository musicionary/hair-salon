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


#####################################

get('/stylists') do
  @stylists = Stylist.all()
  erb(:stylists)
end

get('/stylists/new') do
  erb(:stylist_form)
end



#######################################

get('/clients') do
  @clients = Client.all()
  erb(:clients)
end

get('/clients/new') do
  erb(:client_form)
end
