class Location
  attr_reader(:store_name, :street, :city, :zip, :opening_time, :closing_time, :id)

  define_method(:initialize) do |attributes|
    @store_name = attributes.fetch(:store_name)
    @street = attributes.fetch(:street)
    @city = attributes.fetch(:city)
    @zip = attributes.fetch(:zip)
    @opening_time = attributes.fetch(:opening_time)
    @closing_time = attributes.fetch(:closing_time)
    @id = attributes[:id]
  end

  define_method(:==) do |another_location|
    self.store_name() == another_location.store_name() &&
    self.street() == another_location.street() &&
    self.city() == another_location.city() &&
    self.zip() == another_location.zip() &&
    self.opening_time() == another_location.opening_time() &&
    self.closing_time() == another_location.closing_time()
  end

  define_singleton_method(:all) do
    returned_locations = DB.exec("SELECT * FROM locations;")
    locations = []
    returned_locations.each() do |location|
      store_name = location.fetch("store_name")
      if store_name.include? "ß"
        store_name = store_name.gsub(/ß/, "'")
      end
      street = location.fetch("street")
      if street.include? "ß"
        street = street.gsub(/ß/, "'")
      end
      city = location.fetch("city")
      if city.include? "ß"
        city = city.gsub(/ß/, "'")
      end
      zip = location.fetch("zip")
      opening_time = location.fetch("opening_time")
      closing_time = location.fetch("closing_time")
      id = location.fetch("id").to_i()
      locations.push(Location.new({store_name: store_name, street: street, city: city, zip: zip, opening_time: opening_time, closing_time: closing_time, id: id}))
    end
    locations
  end
  #
  define_method(:save) do
    if @store_name.include? "'"
      @store_name = @store_name.gsub(/'/, "ß")
    end
    if @street.include? "'"
      @street = @street.gsub(/'/, "ß")
    end
    if @city.include? "'"
      @city = @city.gsub(/'/, "ß")
    end
    result = DB.exec("INSERT INTO locations (store_name, street, city, zip, opening_time, closing_time) VALUES ('#{@store_name}', '#{@street}', '#{@city}', '#{@zip}', '#{@opening_time}', '#{@closing_time}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:update) do |attributes|
    @store_name = attributes.fetch(:store_name, @store_name)
    if @store_name.include? "'"
      @store_name = @store_name.gsub(/'/, "ß")
    end
    @street = attributes.fetch(:street, @street)
    if @street.include? "'"
      @street = @street.gsub(/'/, "ß")
    end
    @city = attributes.fetch(:city, @city)
    if @city.include? "'"
      @city = @city.gsub(/'/, "ß")
    end
    @zip = attributes.fetch(:zip, @zip)
    @opening_time = attributes(:opening_time, @opening_time)
    @closing_time = attributes(:closing_time, @closing_time)
    @id = self.id()
    DB.exec("UPDATE locations SET store_name = '#{@store_name}' WHERE id = #{@id};")
    DB.exec("UPDATE locations SET street = '#{@street}' WHERE id = #{@id};")
    DB.exec("UPDATE locations SET city = #{@city} WHERE id = #{@id};")
    DB.exec("UPDATE locations SET zip = #{@zip} WHERE id = #{@id};")
    DB.exec("UPDATE locations SET opening_time = #{@opening_time} WHERE id = #{@id};")
    DB.exec("UPDATE locations SET closing_time = #{@closing_time} WHERE id = #{@id};")
  end

  define_method(:delete) do
    @id = self.id()
    DB.exec("DELETE FROM locations WHERE id = #{@id}")
  end

  define_singleton_method(:find) do |id|
    found_location = nil
    Location.all().each() do |location|
      if location.id == id
        found_location = location
      end
    end
    found_location
  end

  define_method(:stylists) do
    location_stylists = []
    stylists = DB.exec("SELECT * FROM stylists WHERE stylist_id = #{self.id()} ORDER BY name ASC;")
    stylists.each() do |stylist|
      name = stylist.fetch("name")
      station = stylist.fetch("station")
      location_id = stylist.fetch("location_id").to_i()
      id = stylist.fetch("id").to_i()
      specialty_stylists.push(Stylist.new({name: name, station: station, location_id: location_id, id: id}))
    end
    location_stylists
  end
end
