class Client
  attr_reader(:name, :next_appointment, :stylist_id, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @next_appointment = attributes.fetch(:next_appointment)
    @stylist_id = attributes.fetch(:stylist_id)
    @id = attributes[:id]
  end

  define_method(:==) do |another_client|
    self.name() == another_client.name() &&
    self.next_appointment() == another_client.next_appointment() &&
    self.stylist_id() == another_client.stylist_id()
  end

  define_singleton_method(:all) do
    returned_clients = DB.exec("SELECT * FROM clients;")
    clients = []
    returned_clients.each() do |client|
      name = client.fetch("name")
      if name.include? "ß"
        name = name.gsub(/ß/, "'")
      end
      next_appointment = client.fetch("next_appointment")
      stylist_id = client.fetch("stylist_id").to_i()
      id = client.fetch("id").to_i()
      clients.push(Client.new({name: name, next_appointment: next_appointment, stylist_id: stylist_id, id: id}))
    end
    clients
  end
  #
  define_method(:save) do
    if @name.include? "'"
      @name = @name.gsub(/'/, "ß")
    end
    result = DB.exec("INSERT INTO clients (name, next_appointment, stylist_id) VALUES ('#{@name}', '#{@next_appointment}', #{@stylist_id}) RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    if @name.include? "'"
      @name = @name.gsub(/'/, "ß")
    end
    @next_appointment = attributes.fetch(:next_appointment, @next_appointment)
    @stylist_id = attributes.fetch(:stylist_id, @stylist_id).to_i()
    @id = self.id()
    DB.exec("UPDATE clients SET name = '#{@name}' WHERE id = #{@id};")
    DB.exec("UPDATE clients SET next_appointment = '#{@next_appointment}' WHERE id = #{@id};")
    DB.exec("UPDATE clients SET stylist_id = #{@stylist_id} WHERE id = #{@id};")
  end

  define_method(:delete) do
    @id = self.id()
    DB.exec("DELETE FROM clients WHERE id = #{@id}")
  end

  define_singleton_method(:find) do |id|
    found_client = nil
    Client.all().each() do |client|
      if client.id == id
        found_client = client
      end
    end
    found_client
  end
end
