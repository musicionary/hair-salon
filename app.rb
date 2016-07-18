require('sinatra')
require('sinatra/reloader')
also_reload("lib/**/*.rb")
require('./lib/stylist')
require('./lib/client')
require('pg')
require('pry')

DB = PG.connect({:dbname => "hair_salon"})

get("/") do
  erb(:index)
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

  stylist = Stylist.new({name: name, station: station})
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
  @stylist.update({name: name, station: station})
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
  # @stylist = Stylist.find(params.fetch("id").to_i())
  @client = Client.find(params.fetch("id").to_i())
  @client.delete()
  @clients = Client.all()
  erb(:clients)
end
