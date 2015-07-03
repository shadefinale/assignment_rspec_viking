require 'warmup'
describe Warmup do

  let(:warmup) {Warmup.new}

  describe "#gets_shout" do

    it "should shout out what is put in" do
      allow(warmup).to receive(:gets).and_return("yeah")
      expect(warmup.gets_shout).to eq("YEAH")
    end

  end

  describe "#double_size" do

    it "should return double the size of the original array" do
      new_double = double("My_thing", :size=>4)
      expect(warmup.double_size(new_double)).to eq(8)
    end

  end

  describe "#calls_some_methods" do

    it "should call upcase" do
      my_string = "AAA"
      expect(my_string).to receive(:upcase!)
      warmup.calls_some_methods(my_string)
    end

    it "should call reverse" do
      my_string = "AAA"
      expect(my_string).to receive(:reverse!)
      warmup.calls_some_methods(my_string)
    end

    it "should return proper string" do
      my_string = "AAA"
      expect(warmup.calls_some_methods(my_string)).to eq("hahahaha this is a terrible method")
    end

  end

end