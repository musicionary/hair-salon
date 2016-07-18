class Stylist
  attr_reader(:name, :station, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @station = attributes.fetch(:station)
    @id = attributes[:id]
  end

  define_method(:==) do |another_stylist|
    self.name() == another_stylist.name() &&
    self.station() == another_stylist.station()
  end

  define_singleton_method(:all) do
    returned_stylists = DB.exec("SELECT * FROM stylists;")
    stylists = []
    returned_stylists.each() do |stylist|
      name = stylist.fetch("name")
      if name.include? "ß"
        name = name.gsub(/ß/, "'")
      end
      station = stylist.fetch("station")
      if station.include? "ß"
        station = station.gsub(/ß/, "'")
      end
      id = stylist.fetch("id").to_i()
      stylists.push(Stylist.new({name: name, station: station, id: id}))
    end
    stylists
  end

  define_method(:save) do
    if @name.include? "'"
      @name = @name.gsub(/'/, "ß")
    end
    if @station.include? "'"
      @station = @station.gsub(/'/, "ß")
    end
    result = DB.exec("INSERT INTO stylists (name, station) VALUES ('#{@name}', '#{@station}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    if @name.include? "'"
      @name = @name.gsub(/'/, "ß")
    end
    @station = attributes.fetch(:station, @station)
    if @station.include? "'"
      @station = @station.gsub(/'/, "ß")
    end
    @id = self.id()
    DB.exec("UPDATE stylists SET name = '#{@name}' WHERE id = #{@id};")
    DB.exec("UPDATE stylists SET station = '#{@station}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    @id = self.id()
    DB.exec("DELETE FROM stylists WHERE id = #{@id}")
  end

  define_singleton_method(:find) do |id|
    found_stylist = nil
    Stylist.all().each() do |stylist|
      if stylist.id == id
        found_stylist = stylist
      end
    end
    found_stylist
  end

  define_method(:clients) do
    stylist_clients = []
    clients = DB.exec("SELECT * FROM clients WHERE stylist_id = #{self.id()} ORDER BY name ASC;")
    clients.each() do |client|
      name = client.fetch("name")
      next_appointment = client.fetch("next_appointment")
      stylist_id = client.fetch("stylist_id").to_i()
      id = client.fetch("id").to_i()
      stylist_clients.push(Client.new({name: name, next_appointment: next_appointment, stylist_id: stylist_id, id: id}))
    end
    stylist_clients
  end
end
