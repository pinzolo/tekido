# coding: utf-8
require "spec_helper"
require "date"

describe Tekido do
  describe ".yes?" do
    context "with no argument" do
      it "returns true with a probability of about 50 percent" do
        i = 0
        10000.times do
          i += 1 if Tekido.yes?
        end
        expect(i).to be_within(5000).of(100)
      end
    end
    context "with integer argument" do
      it "returns true with a probability of about given percent" do
        i = 0
        10000.times do
          i += 1 if Tekido.yes?(80)
        end
        expect(i).to be_within(8000).of(100)
      end
    end
  end
  describe ".percent" do
    it "returns integer" do
      expect(Tekido.percent).to be_an(Integer)
    end
    it "returns value in range of 0..100" do
      10000.times do
        expect(0..100).to include(Tekido.percent)
      end
    end
  end
  describe ".percent_as" do
    context "with :float argument" do
      it "returns float" do
        expect(Tekido.percent_as(:float)).to be_a(Float)
      end
      it "returns value in range of 0..100" do
        10000.times do
          expect(0..100).to include(Tekido.percent_as(:float))
        end
      end
    end
    context "with :integer argument" do
      it "returns integer" do
        expect(Tekido.percent_as(:integer)).to be_an(Integer)
      end
      it "returns value in range of 0..100" do
        10000.times do
          expect(0..100).to include(Tekido.percent_as(:integer))
        end
      end
    end
    context "with :deca argument" do
      it "returns integer" do
        expect(Tekido.percent_as(:deca)).to be_an(Integer)
      end
      it "returns multiple of 10" do
        10000.times do
          expecteds = 0.upto(10).map { |i| i * 10 }
          expect(expecteds).to include(Tekido.percent_as(:deca))
        end
      end
    end
    context "with other argument" do
      it "returns nil" do
        expect(Tekido.percent_as(:decimal)).to be_nil
      end
    end
  end
  describe ".integer" do
    context "with no argument" do
      it "returns integer" do
        expect(Tekido.integer).to be_an(Integer)
      end
      it "returns random integer value" do
        max = 2 ** 30 - 1
        10000.times do
          expect(0..max).to include(Tekido.integer)
        end
      end
    end
    context "with integer argument" do
      it "returns integer" do
        expect(Tekido.integer).to be_an(Integer)
      end
      it "returns value not over argument" do
        10000.times do
          expect(0..1000).to include(Tekido.integer(1000))
        end
      end
    end
    context "with integer range" do
      it "returns integer" do
        expect(Tekido.integer(0..1000)).to be_an(Integer)
      end
      it "returns value that is included in argument" do
        10000.times do
          expect(0..1000).to include(Tekido.integer(0..1000))
        end
      end
    end
    context "with float range" do
      it "returns integer" do
        expect(Tekido.integer(0..1000.0)).to be_an(Integer)
      end
      it "returns value that is included in argument" do
        10000.times do
          expect(0..1000).to include(Tekido.integer(0..1000.0))
        end
      end
    end
  end
  describe ".float" do
    context "with no argument" do
      it "returns float" do
        expect(Tekido.float).to be_a(Float)
      end
      it "returns value that is 0 or more, less than 1" do
        10000.times do
          expect(0...1).to include(Tekido.float)
        end
      end
    end
    context "with float argument" do
      it "returns float" do
        expect(Tekido.float(1000)).to be_an(Float)
      end
      it "returns value not over argument" do
        10000.times do
          expect(0..1000).to include(Tekido.float(1000))
        end
      end
    end
    context "with integer range" do
      it "returns float" do
        expect(Tekido.float(0..1000)).to be_a(Float)
      end
      it "returns value that is included in argument" do
        10000.times do
          expect(0..1000).to include(Tekido.float(0..1000))
        end
      end
    end
    context "with float range" do
      it "returns float" do
        expect(Tekido.float(0..1000.0)).to be_a(Float)
      end
      it "returns value that is included in argument" do
        10000.times do
          expect(0..1000).to include(Tekido.float(0..1000.0))
        end
      end
    end
  end
  describe ".list" do
    context "when size is 10000, values are :one, :two, :three and :four" do
      let(:list) { Tekido.list(10000, [:one, :two, :three, :four]) }
      it "returns array" do
        expect(list).to be_an(Array)
      end
      it "returned array size is 10000" do
        expect(list.size).to eq 10000
      end
      it "returned array includes about 25% :one" do
        expect(list.count { |item| item == :one }).to be_within(2500).of(100)
      end
      it "returned array includes about 25% :two" do
        expect(list.count { |item| item == :two }).to be_within(2500).of(100)
      end
      it "returned array includes about 25% :three" do
        expect(list.count { |item| item == :three }).to be_within(2500).of(100)
      end
      it "returned array includes about 25% :four" do
        expect(list.count { |item| item == :four }).to be_within(2500).of(100)
      end
    end
    context "when size is 10000, values are defined with ratio (one: 11.1, two: 22.2, three: 33.3, four: 33.4)" do
      let(:list) { Tekido.list(10000, one: 11.1, two: 22.2, three: 33.3, four: 33.4) }
      it "returns array" do
        expect(list).to be_an(Array)
      end
      it "returned array size is 10000" do
        expect(list.size).to eq 10000
      end
      it "returned array includes about 11.1% :one" do
        expect(list.count { |item| item == :one }).to be_within(1110).of(100)
      end
      it "returned array includes about 22.2% :two" do
        expect(list.count { |item| item == :two }).to be_within(2220).of(100)
      end
      it "returned array includes about 33.3% :three" do
        expect(list.count { |item| item == :three }).to be_within(3330).of(100)
      end
      it "returned array includes about 33.4% :four" do
        expect(list.count { |item| item == :four }).to be_within(3340).of(100)
      end
    end
    context "when size is 10000, values are defined with ratio (one: 10, two: 20, three: 30)" do
      let(:list) { Tekido.list(10000, one: 10, two: 20, three: 30) }
      it "Greturns array" do
        expect(list).to be_an(Array)
      end
      it "returned array size is 10000" do
        expect(list.size).to eq 10000
      end
      it "returned array includes about 10% :one" do
        expect(list.count { |item| item == :one }).to be_within(1000).of(100)
      end
      it "returned array includes about 20% :two" do
        expect(list.count { |item| item == :two }).to be_within(2000).of(100)
      end
      it "returned array includes about 30% :three" do
        expect(list.count { |item| item == :three }).to be_within(3000).of(100)
      end
      it "returned array includes about 40% nil" do
        expect(list.count { |item| item.nil? }).to be_within(4000).of(100)
      end
    end
  end
  describe ".date" do
    context "with no argument" do
      it "returns Date" do
        expect(Tekido.date).to be_a(Date)
      end
    end
    context "with integer argument" do
      let(:date) { Tekido.date(1999) }
      it "returns Date" do
        expect(date).to be_a(Date)
      end
      it "returned Date's year is 1999" do
        expect(date.year).to eq 1999
      end
    end
    context "with integer range argument" do
      it "returns Date" do
        expect(Tekido.date(1999..2010)).to be_a(Date)
      end
      it "returns Date's year is included in argument" do
        10000.times do
          expect(1999..2010).to include(Tekido.date(1999..2010).year)
        end
      end
    end
    context "with Date range argument" do
      let(:min) { Date.new(1999, 2, 21) }
      let(:max) { Date.new(2013, 10, 11)}
      it "returns Date" do
        expect(Tekido.date(min..max)).to be_a(Date)
      end
      it "returns Date is included in argument" do
        10.times do
          expect(min..max).to include(Tekido.date(min..max))
        end
      end
    end
  end
end
