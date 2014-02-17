# Tekido

`Tekido` とはさまざまなランダム値を出力するモジュールです。

`Tekido` は以下のメソッドを持っています。

### .yes?

ランダムな真偽値を返します。

```ruby
# true: 50%, false: 50%
Tekido.yes?

# true: 80%, false: 20%
Tekido.yes?(80)
```

### .percent

ランダムで 0 から 100 までの百分率（数値）を返します。`rand(0..100)` と同じ動きをします。

### .percent_as

ランダムで 0 から 100 までの百分率（数値）を返します。戻り値の型などを指定できます。

```ruby
# 整数で返します。
Tekido.percent_as(:integer)

# 小数で返します。
Tekido.percent_as(:float)

# 5の倍数の整数を返します。
Tekido.percent_as(:mo5)

# 10の倍数の整数を返します。
Tekido.percent_as(:deca)
Tekido.percent_as(:mo10)
```

### .integer

ランダムな整数を返します。

```ruby
# 0 から 1073741823 までの範囲にある整数を返します。
Tekido.integer

# 指定の上限を超えない 0 以上の整数を返します。
Tekido.integer(9999)

# 指定の範囲内にある整数を返します。
Tekido.integer(1..1234)
```

### .float

ランダムな小数を返します。

```ruby
# 0 以上 1 未満の小数を返します。
Tekido.float

# 指定の上限を超えない 0 以上の小数を返します。
Tekido.float(777.77)

# 指定の範囲内にある少数を返します。
Tekido.float(1..1234)
Tekido.float(1.1..1234.5)
```

### .list

指定の値と割合でランダムに値を埋めた配列を返します。

```ruby
# 等割合で埋めた配列を返します。('one': 25%, 'two': 25%, 'three': 25%, 'four': 25%)
Tekido.list(10000, %w(one two three four))

# 指定の配分で埋めた配列を返します。
Tekido.list(10000, 'one' => 11.1, 'two' => 22.2, 'three' => 33.3, 'four' => 33.4)

# 足りない部分は nil で埋められます。('one': 10%, 'two': 20%, 'three': 30%, nil: 40% (rests))
Tekido.list(10000, 'one' => 10, 'two' => 20, 'three' => 30)
```

### .date

ランダムな日付を返します。

```ruby
# 0001-01-01 から 9999-12-31 までの日付を返します。
Tekido.date

# 指定の年に所属する日付を返します。
Tekido.date(2010)

# 指定された範囲に所属する年の日付を返します。
Tekido.date(1999..2007)

# 指定された範囲に所属する日付を返します。
Tekido.date(Date.new(1999, 2, 21)..Date.new(2003, 10, 7))
```

### .birthday

誕生日として使用できるランダムな日付を返します。

```ruby
# 現時点で 0 歳から 100 歳までの年齢となる日付を返します。
Tekido.birthday

# 指定された年齢となるランダムな誕生日を返します。
Tekido.birthday(28)

# 指定された範囲に含まれる年齢となるランダムな誕生日を返します。
Tekido.birthday(21..25)
```

### .string

ランダムな文字列を返します。
It returns random String instance.

```ruby
# 1 文字以上、255 文字以内の、大文字・小文字・数字からなるランダムな文字列を返します。
Tekido.string

# 長さが 10 で、大文字と数字からなるランダムな文字列を返します。
Tekido.string(size: 10, components: [:upper, :number])

# 長さが 8 文字以上、16文字以内の、:chars で指定された文字だけで構成されたランダムな文字列を返します。
Tekido.string(size: 8..16, chars: %w(1 3 5 7 9 x y z))
```

### email

ランダムなメールアドレスを返します。

```ruby
# テスト用ドメインのランダムなメールアドレスを返します。
Tekido.email

# ドメインを指定したランダムなメールアドレスを返します。
Tekido.email('foobar.com')

# メールアドレス形式でドメインを指定できます。
Tekido.email('foo.bar@baz.com')

# ドメイン指定は複数可能です。（形式は混在できます）
Tekido.email('test@foo.com', 'bar.com', '@baz.com')
```
