# coding: utf-8
require "spec_helper"

describe Tekido::Methods do
  describe "string methods"do
    describe ".string" do
      context "with no argument" do
        it "returns string" do
          expect(Tekido.string).to be_a(String)
        end
        it "returned string length is within 1..255" do
          TRY_COUNT.times do
            expect(1..255).to include(Tekido.string.size)
          end
        end
        it "returned string is constructed by upper chars and lower chars and numeric chars" do
          TRY_COUNT.times do
            expect(Tekido.string).to match(/\A[a-zA-Z0-9]+\z/)
          end
        end
      end
      context "with size option that has integer value (10)" do
        it "returns string" do
          expect(Tekido.string(size: 10)).to be_a(String)
        end
        it "returned string length is 10" do
          TRY_COUNT.times do
            expect(Tekido.string(size: 10).size).to eq 10
          end
        end
        it "returned string is constructed by upper chars and lower chars and numeric chars" do
          TRY_COUNT.times do
            expect(Tekido.string(size: 10)).to match(/\A[a-zA-Z0-9]+\z/)
          end
        end
      end
      context "with size option that has integer range (8..16)" do
        it "returns string" do
          expect(Tekido.string(size: 8..16)).to be_a(String)
        end
        it "returned string length is within 8..16" do
          TRY_COUNT.times do
            expect(8..16).to include(Tekido.string(size: 8..16).size)
          end
        end
        it "returned string is constructed by upper chars and lower chars and numeric chars" do
          TRY_COUNT.times do
            expect(Tekido.string(size: 8..16)).to match(/\A[a-zA-Z0-9]+\z/)
          end
        end
      end
      context "with components option" do
        it "returns string" do
          expect(Tekido.string(components: [:upper, :lower])).to be_a(String)
        end
        context "components value is :upper" do
          it "returned string is constructed by upper chars" do
            TRY_COUNT.times do
              expect(Tekido.string(components: [:upper])).to match(/\A[A-Z]+\z/)
            end
          end
        end
        context "components value is :lower" do
          it "returned string is constructed by lower chars" do
            TRY_COUNT.times do
              expect(Tekido.string(components: :lower)).to match(/\A[a-z]+\z/)
            end
          end
        end
        context "components value is :number" do
          it "returned string is constructed by numeric chars" do
            TRY_COUNT.times do
              expect(Tekido.string(components: :number)).to match(/\A[0-9]+\z/)
            end
          end
        end
        context "components value is :upper and :lower" do
          it "returned string is constructed by upper chars and lower chars" do
            TRY_COUNT.times do
              expect(Tekido.string(components: [:upper, :lower])).to match(/\A[a-zA-Z]+\z/)
            end
          end
        end
        context "components value is :lower and :number" do
          it "returned string is constructed by lower chars and numeric chars" do
            TRY_COUNT.times do
              expect(Tekido.string(components: [:lower, :number])).to match(/\A[a-z0-9]+\z/)
            end
          end
        end
        context "components value is :upper and :number" do
          it "returned string is constructed by upper chars and numeric chars" do
            TRY_COUNT.times do
              expect(Tekido.string(components: [:upper, :number])).to match(/\A[A-Z0-9]+\z/)
            end
          end
        end
      end
      context "with chars option" do
        it "retuens string" do
          expect(Tekido.string(chars: ('a'..'t').to_a)).to be_a(String)
        end
        it "returned string is constructed by given chars" do
          TRY_COUNT.times do
            expect(Tekido.string(chars: ('a'..'t').to_a)).to match(/\A[a-t]+\z/)
          end
        end
      end
      context "with size and components options" do
        it "returns string" do
          expect(Tekido.string(size: 8..16, components: [:lower, :number])).to be_a(String)
        end
        it "returned string length is within 8..16" do
          TRY_COUNT.times do
            expect(8..16).to include(Tekido.string(size: 8..16, components: [:lower, :number]).size)
          end
        end
        it "returned string is constructed by lower chars and numeric chars" do
          TRY_COUNT.times do
            expect(Tekido.string(size: 8..16, components: [:lower, :number])).to match(/\A[a-z0-9]+\z/)
          end
        end
      end
      context "with size and chars options" do
        it "returns string" do
          expect(Tekido.string(size: 8..16, chars: "String".chars)).to be_a(String)
        end
        it "returned string length is within 8..16" do
          TRY_COUNT.times do
            expect(8..16).to include(Tekido.string(size: 8..16, chars: "String".chars).size)
          end
        end
        it "returned string is constructed by lower chars and numeric chars" do
          TRY_COUNT.times do
            expect(Tekido.string(size: 8..16, chars: "String".chars)).to match(/\A[String]+\z/)
          end
        end
      end
      context "with components and chars options" do
        it "retuens string" do
          expect(Tekido.string(components: [:upper, :lower], chars: %w(1 3 5 7 9))).to be_a(String)
        end
        it "returned string is constructed by chars option value (components option value is ignored)" do
          TRY_COUNT.times do
            expect(Tekido.string(components: [:upper, :lower], chars: %w(1 3 5 7 9))).to match(/\A[13579]+\z/)
          end
        end
      end
    end
  end
end

