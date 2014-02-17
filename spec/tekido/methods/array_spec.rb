# coding: utf-8
require "spec_helper"

describe Tekido::Methods do
  describe "array methods" do
    describe ".list" do
      context "when size is #{TRY_COUNT}, values are :one, :two, :three and :four" do
        let(:list) { Tekido.list(TRY_COUNT, [:one, :two, :three, :four]) }
        it "returns array" do
          expect(list).to be_an(Array)
        end
        it "returned array size is #{TRY_COUNT}" do
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
      context "when size is #{TRY_COUNT}, values are defined with ratio (one: 11.1, two: 22.2, three: 33.3, four: 33.4)" do
        let(:list) { Tekido.list(TRY_COUNT, one: 11.1, two: 22.2, three: 33.3, four: 33.4) }
        it "returns array" do
          expect(list).to be_an(Array)
        end
        it "returned array size is #{TRY_COUNT}" do
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
      context "when size is #{TRY_COUNT}, values are defined with ratio (one: 10, two: 20, three: 30)" do
        let(:list) { Tekido.list(TRY_COUNT, one: 10, two: 20, three: 30) }
        it "returns array" do
          expect(list).to be_an(Array)
        end
        it "returned array size is #{TRY_COUNT}" do
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
      context "when invalid value_defs " do
        let(:list) { Tekido.list(TRY_COUNT, "aaaa") }
        it "returns array" do
          expect(list).to be_an(Array)
        end
        it "returned array is filled by nil" do
          expect(list.any?).to eq false
        end
      end
    end
  end
end
