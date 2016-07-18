require('spec_helper')

describe(Client) do
  describe('#name') do
    it("should return the name of the client") do
      test_client = Client.new({name: "Mary Shelley", next_appointment: "2016-09-09", stylist_id: 1})
      expect(test_client.name()).to(eq("Mary Shelley"))
    end
  end

  describe("#next_appointment") do
    it("should return the next_appointment of the client") do
      test_client = Client.new({name: "Mary Shelley", next_appointment: "2016-09-09", stylist_id: 1})
      expect(test_client.next_appointment()).to(eq("2016-09-09"))
    end
  end

  describe("#stylist_id") do
    it("should return the stylist id of the client") do
      test_client = Client.new({name: "Mary Shelley", next_appointment: "2016-09-09", stylist_id: 1})
      expect(test_client.stylist_id()).to(eq(1))
    end
  end

  describe("#==") do
    it("should be the same client if the name and next appointment and stylist id are the same") do
      client1 = Client.new({name: 'Mary Shelley', next_appointment: "2016-09-09", stylist_id: 1})
      client2 = Client.new({name: 'Mary Shelley', next_appointment: "2016-09-09", stylist_id: 1})
      expect(client1).to(eq(client2))
    end
  end

  describe(".all") do
    it("should be empty at first") do
      expect(Client.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("should add a client to the client database") do
      test_client = Client.new({name: 'Mary Shelley', next_appointment: "2016-09-09", stylist_id: 1})
      test_client.save()
      expect(Client.all()).to(eq([test_client]))
    end
  end

  describe("#update") do
    it("should update a client's name and/or station") do
      test_client = Client.new({name: 'Mary Shelley', next_appointment: "2016-09-09", stylist_id: 1})
      test_client.save()
      expect(Client.all()).to(eq([test_client]))
      test_client.update({name: "Bob Ross", next_appointment: "2016-09-09", stylist_id: 1})
      expect(test_client.name()).to(eq("Bob Ross"))
    end
  end

  describe("#delete") do
    it("should delete the client from the database") do
      client1 = Client.new({name: 'Mary Shelley', next_appointment: "2016-09-09", stylist_id: 1})
      client1.save()
      client2 = Client.new({name: 'Mary Shelley', next_appointment: "2016-09-09", stylist_id: 1})
      client2.save()
      client1.delete()
      expect(Client.all()).to(eq([client2]))
    end
  end

  describe(".find") do
    it("should find a client by its id") do
      client1 = Client.new({name: 'Mary Shelley', next_appointment: "2016-09-09", stylist_id: 1})
      client1.save()
      expect(Client.find(client1.id())).to(eq(client1))
    end
  end
end
