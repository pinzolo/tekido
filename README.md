# Tekido

[![Build Status](https://secure.travis-ci.org/pinzolo/tekido.png)](http://travis-ci.org/pinzolo/tekido)
[![Coverage Status](https://coveralls.io/repos/pinzolo/tekido/badge.png)](https://coveralls.io/r/pinzolo/tekido)

A handy little random library.

## Installation

Add this line to your application's Gemfile:

    gem 'tekido'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tekido

## Usage

`Tekido` has below methods.

### .yes?

It returns random boolean

```ruby
# true: 50%, false 50%
Tekido.yes?

# true: 80%, false 20%
Tekido.yes?(80)
```

### .percent

It retuens random percentage (0..100). It behaves the same as `rand(0..100)`.

### .percent_as

It returns random percentage. Can select return value type.

```ruby
# returns integer (same as Tekido.percent)
Tekido.percent_as(:integer)

# returns float
Tekido.percent_as(:float)

# returns integer that is multiple of 10 (ex. 10, 70)
Tekido.percent_as(:deca)
```

### .integer

It always returns random value as integer.

```ruby
# returns integer (0 <= value <= 1073741823)
Tekido.integer

# returns integer that not over argument
Tekido.integer(9999)

# returns integer that is included in argument
Tekido.integer(1..1234)
```

### .float

It always returns random value as float. The different with `rand` is return value type only.

```ruby
# returns float (0 <= value < 1)
Tekido.float

# returns float that not over argument
Tekido.float(777.77)

# returns float that is included in argument
Tekido.float(1..1234)
```

### .list

It returns Array instance that is filled by given sample values and ratio.

```ruby
# 'one': 25%, 'two': 25%, 'three': 25%, 'four': 25%
Tekido.list(10000, %w(one two three four))

# 'one': 11.1%, 'two': 22.2%, 'three': 33.3%, 'four': 33.4%
Tekido.list(10000, 'one' => 11.1, 'two' => 22.2, 'three' => 33.3, 'four' => 33.4)

# 'one': 10%, 'two': 20%, 'three': 30%, rests(40%) are nil
Tekido.list(10000, 'one' => 10, 'two' => 20, 'three' => 30)
```

### .date

It returns random Date.

```ruby
# returns Date (0001-01-01 <= value <= 9999-12-31)
Tekido.date

# returns Date (2010-01-01 <= value <= 2010-12-31)
Tekido.date(2010)

# returns Date (1999-01-01 <= value <= 2007-12-31)
Tekido.date(1999..2007)

# returns Date (1999-02-21 <= value <= 2003-10-07)
Tekido.date(Date.new(1999, 2, 21)..Date.new(2003, 10, 7))
```

### .birthday

It returns random birthday.

```ruby
# returns birthday satisfying that current age is more than 0 and less than 100
Tekido.birthday

# returns birthday satisfying that current age is given argument
Tekido.birthday(28)

# returns birthday satisfying that current age is within given argument
Tekido.birthday(21..25)
```

## Supported ruby versions

* 1.9.3
* 2.0.0
* 2.1.0

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
