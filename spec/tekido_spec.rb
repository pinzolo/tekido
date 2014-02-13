# coding: utf-8
require "spec_helper"

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
end
