require('spec_helper')

describe(Location) do
  describe('#store_name') do
    it("should return the store name of the location") do
      test_location = Location.new({store_name: "Westside", street: "201 Westbrook Road", city: "Nantucket", zip: "40223", opening_time: "09:00:00", closing_time: "03:00:00"})
      expect(test_location.store_name()).to(eq("Westside"))
    end
  end

  describe("#street") do
    it("should return the street of the location") do
      test_location = Location.new({store_name: "Westside", street: "201 Westbrook Road", city: "Nantucket", zip: "40223", opening_time: "09:00:00", closing_time: "03:00:00"})
      expect(test_location.street()).to(eq("201 Westbrook Road"))
    end
  end

  describe("#city") do
    it("should return the city of the location") do
      test_location = Location.new({store_name: "Westside", street: "201 Westbrook Road", city: "Nantucket", zip: "40223", opening_time: "09:00:00", closing_time: "03:00:00"})
      expect(test_location.city()).to(eq("Nantucket"))
    end
  end

  describe("#zip") do
    it("should return the zip of the location") do
      test_location = Location.new({store_name: "Westside", street: "201 Westbrook Road", city: "Nantucket", zip: "40223", opening_time: "09:00:00", closing_time: "03:00:00"})
      expect(test_location.zip()).to(eq("40223"))
    end
  end

  describe("#opening_time") do
    it("should return the opening time of the location") do
      test_location = Location.new({store_name: "Westside", street: "201 Westbrook Road", city: "Nantucket", zip: "40223", opening_time: "09:00:00", closing_time: "03:00:00"})
      expect(test_location.opening_time()).to(eq("09:00:00"))
    end
  end

  describe("#closing_time") do
    it("should return the closing time of the location") do
      test_location = Location.new({store_name: "Westside", street: "201 Westbrook Road", city: "Nantucket", zip: "40223", opening_time: "09:00:00", closing_time: "03:00:00"})
      expect(test_location.closing_time()).to(eq("03:00:00"))
    end
  end



  describe("#==") do
    it("should be the same location if the attributes are the same") do
      test_location = Location.new({store_name: "Westside", street: "201 Westbrook Road", city: "Nantucket", zip: "40223", opening_time: "09:00:00", closing_time: "03:00:00"})
      test_location2 = Location.new({store_name: "Westside", street: "201 Westbrook Road", city: "Nantucket", zip: "40223", opening_time: "09:00:00", closing_time: "03:00:00"})
      expect(test_location).to(eq(test_location2))
    end
  end

  describe(".all") do
    it("should be empty at first") do
      expect(Location.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("should add a location to the location database") do
      test_location = Location.new({store_name: "Westside", street: "201 Westbrook Road", city: "Nantucket", zip: "40223", opening_time: "09:00:00", closing_time: "03:00:00"})
      test_location.save()
      expect(Location.all()).to(eq([test_location]))
    end
  end

  describe("#update") do
    it("should update a locations's attributes") do
      test_location = Location.new({store_name: "Westside", street: "201 Westbrook Road", city: "Nantucket", zip: "40223", opening_time: "09:00:00", closing_time: "03:00:00"})
      test_location.save()
      expect(Location.all()).to(eq([test_location]))
      test_location = Location.new({store_name: "Stonybrook", street: "201 Westbrook Road", city: "Nantucket", zip: "40223", opening_time: "09:00:00", closing_time: "03:00:00"})
      expect(test_location.store_name()).to(eq("Stonybrook"))
    end
  end

  describe("#delete") do
    it("should delete the location from the database") do
      test_location = Location.new({store_name: "Westside", street: "201 Westbrook Road", city: "Nantucket", zip: "40223", opening_time: "09:00:00", closing_time: "03:00:00"})
      test_location.save()
      test_location2 = Location.new({store_name: "Westside", street: "201 Westbrook Road", city: "Nantucket", zip: "40223", opening_time: "09:00:00", closing_time: "03:00:00"})
      test_location2.save()
      test_location.delete()
      expect(Location.all()).to(eq([test_location2]))
    end
  end

  describe(".find") do
    it("should find a location by its id") do
      test_location = Location.new({store_name: "Westside", street: "201 Westbrook Road", city: "Nantucket", zip: "40223", opening_time: "09:00:00", closing_time: "03:00:00"})
      test_location.save()
      expect(Location.find(test_location.id())).to(eq(test_location))
    end
  end
end
