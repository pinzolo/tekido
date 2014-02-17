# coding: utf-8
require "spec_helper"

describe Tekido::Methods do
  describe "percentage methods" do
    describe ".percent" do
      it "returns integer" do
        expect(Tekido.percent).to be_an(Integer)
      end
      it "at random uniformly" do
        list = TRY_COUNT.times.map { Tekido.percent }
        expect(list.uniq.size).to be >= expected_count(101)
      end
      it "returns value in range of 0..100" do
        TRY_COUNT.times do
          expect(0..100).to include(Tekido.percent)
        end
      end
    end
    describe ".percent_as" do
      context "with :float argument" do
        it "returns float" do
          expect(Tekido.percent_as(:float)).to be_a(Float)
        end
        it "at random uniformly" do
          list = TRY_COUNT.times.map { Tekido.percent_as(:float) }
          expect(list.uniq.size).to be >= expected_count
        end
        it "returns value in range of 0..100" do
          TRY_COUNT.times do
            expect(0..100).to include(Tekido.percent_as(:float))
          end
        end
      end
      context "with :integer argument" do
        it "returns integer" do
          expect(Tekido.percent_as(:integer)).to be_an(Integer)
        end
        it "at random uniformly" do
          list = TRY_COUNT.times.map { Tekido.percent_as(:integer) }
          expect(list.uniq.size).to be >= expected_count(101)
        end
        it "returns value in range of 0..100" do
          TRY_COUNT.times do
            expect(0..100).to include(Tekido.percent_as(:integer))
          end
        end
      end
      context "with :mo5 argument" do
        it "returns integer" do
          expect(Tekido.percent_as(:mo5)).to be_an(Integer)
        end
        it "at random uniformly" do
          list = TRY_COUNT.times.map { Tekido.percent_as(:mo5) }
          expect(list.uniq.size).to be >= expected_count(21)
        end
        it "returns multiple of 5" do
          TRY_COUNT.times do
            expecteds = 0.upto(20).map { |i| i * 5 }
            expect(expecteds).to include(Tekido.percent_as(:mo5))
          end
        end
      end
      context "with :deca argument" do
        it "returns integer" do
          expect(Tekido.percent_as(:deca)).to be_an(Integer)
        end
        it "at random uniformly" do
          list = TRY_COUNT.times.map { Tekido.percent_as(:deca) }
          expect(list.uniq.size).to be >= expected_count(11)
        end
        it "returns multiple of 10" do
          TRY_COUNT.times do
            expecteds = 0.upto(10).map { |i| i * 10 }
            expect(expecteds).to include(Tekido.percent_as(:deca))
          end
        end
      end
      context "with :mo10 argument" do
        it "returns integer" do
          expect(Tekido.percent_as(:mo10)).to be_an(Integer)
        end
        it "at random uniformly" do
          list = TRY_COUNT.times.map { Tekido.percent_as(:mo10) }
          expect(list.uniq.size).to be >= expected_count(11)
        end
        it "returns multiple of 10" do
          TRY_COUNT.times do
            expecteds = 0.upto(10).map { |i| i * 10 }
            expect(expecteds).to include(Tekido.percent_as(:mo10))
          end
        end
      end
      context "with other argument" do
        it "returns nil" do
          expect(Tekido.percent_as(:decimal)).to be_nil
        end
      end
    end
  end
end

