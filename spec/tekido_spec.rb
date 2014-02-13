# coding: utf-8
require "spec_helper"
require "date"

TRY_COUNT = 10000
ACCIDENTAL_RATE = 0.01
ACCIDENTAL_COUNT = TRY_COUNT * ACCIDENTAL_RATE

def valid_count(percent)
  TRY_COUNT / 100 * percent
end

describe Tekido do
  describe ".yes?" do
    context "with no argument" do
      it "returns true with a probability of about 50 percent" do
        i = 0
        TRY_COUNT.times do
          i += 1 if Tekido.yes?
        end
        expect(i).to be_within(TRY_COUNT / 2).of(ACCIDENTAL_COUNT)
      end
    end
    context "with integer argument" do
      it "returns true with a probability of about given percent" do
        i = 0
        TRY_COUNT.times do
          i += 1 if Tekido.yes?(80)
        end
        expect(i).to be_within(valid_count(80)).of(ACCIDENTAL_COUNT)
      end
    end
  end
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
  describe ".list" do
    context "when size is TRY_COUNT, values are :one, :two, :three and :four" do
      let(:list) { Tekido.list(TRY_COUNT, [:one, :two, :three, :four]) }
      it "returns array" do
        expect(list).to be_an(Array)
      end
      it "returned array size is TRY_COUNT" do
        expect(list.size).to eq TRY_COUNT
      end
      it "returned array includes about 25% :one" do
        expect(list.count { |item| item == :one }).to be_within(valid_count(25)).of(ACCIDENTAL_COUNT)
      end
      it "returned array includes about 25% :two" do
        expect(list.count { |item| item == :two }).to be_within(valid_count(25)).of(ACCIDENTAL_COUNT)
      end
      it "returned array includes about 25% :three" do
        expect(list.count { |item| item == :three }).to be_within(valid_count(25)).of(ACCIDENTAL_COUNT)
      end
      it "returned array includes about 25% :four" do
        expect(list.count { |item| item == :four }).to be_within(valid_count(25)).of(ACCIDENTAL_COUNT)
      end
    end
    context "when size is TRY_COUNT, values are defined with ratio (one: 11.1, two: 22.2, three: 33.3, four: 33.4)" do
      let(:list) { Tekido.list(TRY_COUNT, one: 11.1, two: 22.2, three: 33.3, four: 33.4) }
      it "returns array" do
        expect(list).to be_an(Array)
      end
      it "returned array size is TRY_COUNT" do
        expect(list.size).to eq TRY_COUNT
      end
      it "returned array includes about 11.1% :one" do
        expect(list.count { |item| item == :one }).to be_within(valid_count(11.1)).of(ACCIDENTAL_COUNT)
      end
      it "returned array includes about 22.2% :two" do
        expect(list.count { |item| item == :two }).to be_within(valid_count(22.2)).of(ACCIDENTAL_COUNT)
      end
      it "returned array includes about 33.3% :three" do
        expect(list.count { |item| item == :three }).to be_within(valid_count(33.3)).of(ACCIDENTAL_COUNT)
      end
      it "returned array includes about 33.4% :four" do
        expect(list.count { |item| item == :four }).to be_within(valid_count(33.4)).of(ACCIDENTAL_COUNT)
      end
    end
    context "when size is TRY_COUNT, values are defined with ratio (one: 10, two: 20, three: 30)" do
      let(:list) { Tekido.list(TRY_COUNT, one: 10, two: 20, three: 30) }
      it "Greturns array" do
        expect(list).to be_an(Array)
      end
      it "returned array size is TRY_COUNT" do
        expect(list.size).to eq TRY_COUNT
      end
      it "returned array includes about 10% :one" do
        expect(list.count { |item| item == :one }).to be_within(valid_count(10)).of(ACCIDENTAL_COUNT)
      end
      it "returned array includes about 20% :two" do
        expect(list.count { |item| item == :two }).to be_within(valid_count(20)).of(ACCIDENTAL_COUNT)
      end
      it "returned array includes about 30% :three" do
        expect(list.count { |item| item == :three }).to be_within(valid_count(30)).of(ACCIDENTAL_COUNT)
      end
      it "returned array includes about 40% nil" do
        expect(list.count { |item| item.nil? }).to be_within(valid_count(40)).of(ACCIDENTAL_COUNT)
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
      it "returned Date is included in from 100 years ago to today" do
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
      it "age is included in argument" do
        min = (Date.today << 12 * 21) + 1
        max = Date.today << 12 * 25
        TRY_COUNT.times do
          expect(min..max).to include(Tekido.birthday(20..25))
        end
      end
    end
  end
end
