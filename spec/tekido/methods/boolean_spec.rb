# coding: utf-8
require "spec_helper"

describe Tekido::Methods do
  describe "boolean methods"do
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
      context "with invalid argument" do
        it "bahaves in the same way of no argument" do
          i = 0
          TRY_COUNT.times do
            i += 1 if Tekido.yes?("99")
          end
          expect(i).to be_within(TRY_COUNT / 2).of(ACCIDENTAL_COUNT)
        end
      end
    end
  end
end
