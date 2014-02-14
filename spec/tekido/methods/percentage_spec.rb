# coding: utf-8
require "spec_helper"

describe Tekido::Methods do
  describe "percentage methods" do
    describe ".percent" do
      it "returns integer" do
        expect(Tekido.percent).to be_an(Integer)
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
        it "returns value in range of 0..100" do
          TRY_COUNT.times do
            expect(0..100).to include(Tekido.percent_as(:integer))
          end
        end
      end
      context "with :deca argument" do
        it "returns integer" do
          expect(Tekido.percent_as(:deca)).to be_an(Integer)
        end
        it "returns multiple of 10" do
          TRY_COUNT.times do
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
  end
end

