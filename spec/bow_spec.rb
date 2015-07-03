require 'weapons/bow'

describe Bow do

  let (:bow){Bow.new}

  describe "#initialize" do

    it "should have readable arrow count" do
      expect(bow).to respond_to(:arrows)
    end

    it "should initialize with 10 arrows" do
      expect(bow.arrows).to eq(10)
    end

    it "should initialize with a specified amount of arrows" do
      new_bow = Bow.new(24)
      expect(new_bow.arrows).to eq(24)
    end
  end

  describe "#use" do

    it "should reduce arrow count by 1 when used" do
      bow.use
      expect(bow.arrows).to eq(9)
      bow.use
      expect(bow.arrows).to eq(8)
      bow.use
      expect(bow.arrows).to eq(7)
      bow.use
      expect(bow.arrows).to eq(6)
    end

    it "should throw an error when out of ammo" do
      10.times do
        bow.use
      end
      expect{bow.use}.to raise_error
    end

  end

end