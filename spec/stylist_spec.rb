require('spec_helper')

describe(Stylist) do
  describe('#name') do
    it("should return the name of the stylist") do
      test_stylist = Stylist.new({name: "Mary Shelley", station: "1", location_id: 1})
      expect(test_stylist.name()).to(eq("Mary Shelley"))
    end
  end

  describe("#station") do
    it("should return the station of the stylist") do
      test_stylist = Stylist.new({name: "Mary Shelley", station: "1", location_id: 1})
      expect(test_stylist.station()).to(eq("1"))
    end
  end

  describe("#==") do
    it("should be the same stylist if the name and station are the same") do
      test_stylist = Stylist.new({name: "Mary Shelley", station: "1", location_id: 1})
      test_stylist2 = Stylist.new({name: "Mary Shelley", station: "1", location_id: 1})
      expect(test_stylist).to(eq(test_stylist2))
    end
  end

  describe(".all") do
    it("should be empty at first") do
      expect(Stylist.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("should add a stylist to the stylist database") do
      test_stylist = Stylist.new({name: "Mary Shelley", station: "1", location_id: 1})
      test_stylist.save()
      expect(Stylist.all()).to(eq([test_stylist]))
    end
  end

  describe("#update") do
    it("should update a stylists name and/or station") do
      test_stylist = Stylist.new({name: "Mary Shelley", station: "1", location_id: 1})
      test_stylist.save()
      expect(Stylist.all()).to(eq([test_stylist]))
      test_stylist.update({name: "Bob Ross", station: "2", location_id: 1})
      expect(test_stylist.name()).to(eq("Bob Ross"))
    end
  end

  describe("#delete") do
    it("should delete the stylist from the database") do
      test_stylist = Stylist.new({name: "Mary Shelley", station: "1", location_id: 1})
      test_stylist.save()
      test_stylist2 = Stylist.new({name: "Mary Shelley", station: "1", location_id: 1})
      test_stylist2.save()
      test_stylist.delete()
      expect(Stylist.all()).to(eq([test_stylist2]))
    end
  end

  describe(".find") do
    it("should find a stylist by its id") do
      test_stylist = Stylist.new({name: "Mary Shelley", station: "1", location_id: 1})
      test_stylist.save()
      expect(Stylist.find(test_stylist.id())).to(eq(test_stylist))
    end
  end

  describe("#clients") do
    it("should return the list of cliests for a particular stylist") do
      test_stylist = Stylist.new({name: "Mary Shelley", station: "1", location_id: 1})
      test_stylist.save()
      client1 = Client.new({name: "Joe Watts", next_appointment: "2016-09-09 00:00:00", stylist_id: test_stylist.id(), id: nil})
      client1.save()
      client2 = Client.new({name: "Alison Hill", next_appointment: "2016-09-09 00:00:00", stylist_id: test_stylist.id(), id: nil})
      client2.save()
      expect(test_stylist.clients()).to(eq([client2, client1]))
    end
  end
end
