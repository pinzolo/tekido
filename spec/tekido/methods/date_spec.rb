# coding: utf-8
require "spec_helper"
require "date"

describe Tekido::Methods do
  describe "date methods" do
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
        it "returned Date's year is included in argument" do
          TRY_COUNT.times do
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
        it "returned Date is included in argument" do
          TRY_COUNT.times do
            expect(min..max).to include(Tekido.date(min..max))
          end
        end
      end
    end
    describe ".birthday" do
      context "with no argument" do
        it "returns Date" do
          expect(Tekido.birthday).to be_a(Date)
        end
        it "returned Date satisfy that current age is more than 0 and less than 100" do
          min = Date.today << 12 * 100
          TRY_COUNT.times do
            expect(min..Date.today).to include(Tekido.birthday)
          end
        end
      end
      context "with integer argument" do
        it "returns Date" do
          expect(Tekido.birthday(20)).to be_a(Date)
        end
        it "given integer is age" do
          age = 28
          min = (Date.today << 12 * (age + 1)) + 1
          max = Date.today << 12 * age
          TRY_COUNT.times do
            expect(min..max).to include(Tekido.birthday(age))
          end
        end
      end
      context "with integer range argument" do
        it "returns Date" do
          expect(Tekido.birthday(20..25)).to be_a(Date)
        end
        it "returned Date satisfy that current age is included in argument" do
          min = (Date.today << 12 * 26) + 1
          max = Date.today << 12 * 20
          TRY_COUNT.times do
            expect(min..max).to include(Tekido.birthday(20..25))
          end
        end
      end
    end
  end
end

