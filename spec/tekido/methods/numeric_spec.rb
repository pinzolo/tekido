# coding: utf-8
require "spec_helper"

describe Tekido::Methods do
  describe "numeric methods" do
    describe ".integer" do
      context "with no argument" do
        it "returns integer" do
          expect(Tekido.integer).to be_an(Integer)
        end
        it "returns random integer value" do
          max = 2 ** 30 - 1
          TRY_COUNT.times do
            expect(0..max).to include(Tekido.integer)
          end
        end
      end
      context "with integer argument" do
        it "returns integer" do
          expect(Tekido.integer).to be_an(Integer)
        end
        it "returns value not over argument" do
          TRY_COUNT.times do
            expect(0..1000).to include(Tekido.integer(1000))
          end
        end
      end
      context "with integer range" do
        it "returns integer" do
          expect(Tekido.integer(0..1000)).to be_an(Integer)
        end
        it "returns value that is included in argument" do
          TRY_COUNT.times do
            expect(0..1000).to include(Tekido.integer(0..1000))
          end
        end
      end
      context "with float range" do
        it "returns integer" do
          expect(Tekido.integer(0..1000.0)).to be_an(Integer)
        end
        it "returns value that is included in argument" do
          TRY_COUNT.times do
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
          TRY_COUNT.times do
            expect(0...1).to include(Tekido.float)
          end
        end
      end
      context "with float argument" do
        it "returns float" do
          expect(Tekido.float(1000)).to be_an(Float)
        end
        it "returns value not over argument" do
          TRY_COUNT.times do
            expect(0..1000).to include(Tekido.float(1000))
          end
        end
      end
      context "with integer range" do
        it "returns float" do
          expect(Tekido.float(0..1000)).to be_a(Float)
        end
        it "returns value that is included in argument" do
          TRY_COUNT.times do
            expect(0..1000).to include(Tekido.float(0..1000))
          end
        end
      end
      context "with float range" do
        it "returns float" do
          expect(Tekido.float(0..1000.0)).to be_a(Float)
        end
        it "returns value that is included in argument" do
          TRY_COUNT.times do
            expect(0..1000).to include(Tekido.float(0..1000.0))
          end
        end
      end
    end
  end
end
