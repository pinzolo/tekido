# coding: utf-8
require "spec_helper"

EXAMPLE_DOMAINS = ["example.com", "exmple.net", "example.org", "example.jp", "example.co.jp", "example.ne.jp"] +
  (0..9).map { |i| ["example#{i}.jp", "example#{i}.co.jp", "example#{i}.ne.jp"] }.flatten

describe Tekido::Methods do
  describe "string methods"do
    describe ".string" do
      context "with no argument" do
        it "returns string" do
          expect(Tekido.string).to be_a(String)
        end
        it "at random uniformly" do
          list = TRY_COUNT.times.map { Tekido.string }
          expect(list.uniq.size).to be >= expected_count
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
        it "at random uniformly" do
          list = TRY_COUNT.times.map { Tekido.string(size: 10) }
          expect(list.uniq.size).to be >= expected_count
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
        it "at random uniformly" do
          list = TRY_COUNT.times.map { Tekido.string(size: 8..16) }
          expect(list.uniq.size).to be >= expected_count
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
        it "at random uniformly" do
          list = TRY_COUNT.times.map { Tekido.string(components: [:upper, :lower]) }
          expect(list.uniq.size).to be >= expected_count
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
        it "at random uniformly" do
          list = TRY_COUNT.times.map { Tekido.string(chars: ('a'..'t').to_a) }
          expect(list.uniq.size).to be >= expected_count
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
        it "at random uniformly" do
          list = TRY_COUNT.times.map { Tekido.string(size: 8..16, components: [:lower, :number]) }
          expect(list.uniq.size).to be >= expected_count
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
          expect(Tekido.string(size: 8..16, chars: "String".chars.to_a)).to be_a(String)
        end
        it "at random uniformly" do
          list = TRY_COUNT.times.map { Tekido.string(size: 8..16, chars: "String".chars.to_a) }
          expect(list.uniq.size).to be >= expected_count
        end
        it "returned string length is within 8..16" do
          TRY_COUNT.times do
            expect(8..16).to include(Tekido.string(size: 8..16, chars: "String".chars.to_a).size)
          end
        end
        it "returned string is constructed by given characters" do
          TRY_COUNT.times do
            expect(Tekido.string(size: 8..16, chars: "String".chars.to_a)).to match(/\A[String]+\z/)
          end
        end
      end
      context "with components and chars options" do
        it "retuens string" do
          expect(Tekido.string(components: [:upper, :lower], chars: %w(1 3 5 7 9))).to be_a(String)
        end
        it "at random uniformly" do
          list = TRY_COUNT.times.map { Tekido.string(components: [:upper, :lower], chars: %w(1 3 5 7 9)) }
          expect(list.uniq.size).to be >= expected_count
        end
        it "returned string is constructed by chars option value (components option value is ignored)" do
          TRY_COUNT.times do
            expect(Tekido.string(components: [:upper, :lower], chars: %w(1 3 5 7 9))).to match(/\A[13579]+\z/)
          end
        end
      end
    end
    describe ".email" do
      context "with no argument" do
        it "returns string as email address" do
          expect(Tekido.email).to be_a(String)
        end
        it "at random uniformly" do
          list = TRY_COUNT.times.map { Tekido.email }
          expect(list.uniq.size).to be >= expected_count
        end
        it "returns email address that has size within 3..32" do
          TRY_COUNT.times do
            expect(3..32).to include(Tekido.email.index("@"))
          end
        end
        it "returns email address that end with example domain" do
          TRY_COUNT.times do
            email = Tekido.email
            expect(EXAMPLE_DOMAINS).to include(email[email.index('@')+1..email.size])
          end
        end
      end
      context "with domain string argument" do
        it "returns string as email address" do
          expect(Tekido.email("foobar.com")).to be_a(String)
        end
        it "at random uniformly" do
          list = TRY_COUNT.times.map { Tekido.email("foobar.com") }
          expect(list.uniq.size).to be >= expected_count
        end
        it "returns email address that has size within 3..32" do
          TRY_COUNT.times do
            expect(3..32).to include(Tekido.email("foobar.com").index("@"))
          end
        end
        it "returns email address that end with given domain" do
          TRY_COUNT.times do
            expect(Tekido.email("foobar.com")).to end_with("foobar.com")
          end
        end
      end
      context "with base address argument" do
        it "returns string" do
          expect(Tekido.email("foo.bar@baz.com")).to be_a(String)
        end
        it "at random uniformly" do
          list = TRY_COUNT.times.map { Tekido.email("foo.bar@baz.com") }
          expect(list.uniq.size).to be >= expected_count
        end
        it "returns email address that has size within 3..32" do
          TRY_COUNT.times do
            expect(3..32).to include(Tekido.email("foo.bar@baz.com").index("@"))
          end
        end
        it "returns email address that end with given domain" do
          TRY_COUNT.times do
            expect(Tekido.email("foo.bar@baz.com")).to end_with("baz.com")
          end
        end
        it "returns email address that not equals given mail" do
          TRY_COUNT.times do
            expect(Tekido.email("foo.bar@baz.com")).to end_with("baz.com")
          end
        end
      end
      context "with multiple address arguments" do
        it "returns string" do
          expect(Tekido.email("test@foo.com", "bar.com", "@baz.com")).to be_a(String)
        end
        it "at random uniformly" do
          list = TRY_COUNT.times.map { Tekido.email("test@foo.com", "bar.com", "@baz.com") }
          expect(list.uniq.size).to be >= expected_count
        end
        it "returns email address that has size within 3..32" do
          TRY_COUNT.times do
            expect(3..32).to include(Tekido.email("test@foo.com", "bar.com", "@baz.com").index("@"))
          end
        end
        it "returns email address that end with given domain" do
          TRY_COUNT.times do
            email = Tekido.email("test@foo.com", "bar.com", "@baz.com")
            expected_domains = ["foo.com", "bar.com", "baz.com"]
            expect(expected_domains).to include(email[email.index("@")+1..email.length])
          end
        end
      end
    end
  end
end

