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
        it "at random uniformly" do
          min, max = Date.new(1, 1, 1), Date.new(9999, 12, 31)
          list = TRY_COUNT.times.map { Tekido.date }
          expect(list.uniq.size).to be >= expected_count(max - min)
        end
      end
      context "with integer argument" do
        let(:date) { Tekido.date(1999) }
        it "returns Date" do
          expect(date).to be_a(Date)
        end
        it "at random uniformly" do
          min, max = Date.new(1999, 1, 1), Date.new(1999, 12, 31)
          list = TRY_COUNT.times.map { Tekido.date(1999) }
          expect(list.uniq.size).to be >= expected_count(max - min)
        end
        it "returned Date's year is 1999" do
          expect(date.year).to eq 1999
        end
      end
      context "with integer range argument" do
        it "returns Date" do
          expect(Tekido.date(1999..2010)).to be_a(Date)
        end
        it "at random uniformly" do
          min, max = Date.new(1999, 1, 1), Date.new(2010, 12, 31)
          list = TRY_COUNT.times.map { Tekido.date(1999..2010) }
          expect(list.uniq.size).to be >= expected_count(max - min)
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
        it "at random uniformly" do
          list = TRY_COUNT.times.map { Tekido.date(min..max) }
          expect(list.uniq.size).to be >= expected_count(max - min)
        end
        it "returned Date is included in argument" do
          TRY_COUNT.times do
            expect(min..max).to cover(Tekido.date(min..max))
          end
        end
      end
      context "with invalid argument" do
        it "returns nil" do
          expect(Tekido.date("2010")).to be_nil
        end
      end
    end
    describe ".birthday" do
      context "with no argument" do
        it "returns Date" do
          expect(Tekido.birthday).to be_a(Date)
        end
        it "at random uniformly" do
          min = (Date.today << 12 * 101) + 1
          list = TRY_COUNT.times.map { Tekido.birthday }
          expect(list.uniq.size).to be >= expected_count(Date.today - min)
        end
        it "returned Date satisfy that current age is more than 0 and less than 100" do
          min = (Date.today << 12 * 101) + 1
          TRY_COUNT.times do
            expect(min..Date.today).to cover(Tekido.birthday)
          end
        end
      end
      context "with integer argument" do
        let(:age) { 28 }
        it "returns Date" do
          expect(Tekido.birthday(age)).to be_a(Date)
        end
        it "at random uniformly" do
          min = (Date.today << 12 * (age + 1)) + 1
          max = Date.today << 12 * age
          list = TRY_COUNT.times.map { Tekido.birthday }
          expect(list.uniq.size).to be >= expected_count(max - min)
        end
        it "given integer is age" do
          min = (Date.today << 12 * (age + 1)) + 1
          max = Date.today << 12 * age
          TRY_COUNT.times do
            expect(min..max).to cover(Tekido.birthday(age))
          end
        end
      end
      context "with integer range argument" do
        it "returns Date" do
          expect(Tekido.birthday(20..25)).to be_a(Date)
        end
        it "at random uniformly" do
          min = (Date.today << 12 * 26) + 1
          max = Date.today << 12 * 20
          list = TRY_COUNT.times.map { Tekido.birthday }
          expect(list.uniq.size).to be >= expected_count(max - min)
        end
        it "returned Date satisfy that current age is included in argument" do
          min = (Date.today << 12 * 26) + 1
          max = Date.today << 12 * 20
          TRY_COUNT.times do
            expect(min..max).to cover(Tekido.birthday(20..25))
          end
        end
      end
      context "with invalid argument" do
        it "returns nil" do
          expect(Tekido.birthday("30")).to be_nil
        end
      end
    end
  end
end

