require 'active_support'
require 'active_support/core_ext'

# .blank? check the string is blank or not
puts ' '.blank?           # true
puts "\n".blank?          # true

# .present? returns true is string is not blank
puts ' '.present?           # false
puts "\n".present?          # false

# .presence returns the value itself if it is not blank otherwise returns nil.
puts ' '.presence                   # nil
puts 'hello ruby'.presence          # hello ruby

# .dup will duplicate the object.
a = 'hello'
b = a.dup
puts b # hello

# .duplicable? will check that object is duplicable or not.
a = 'hello'
puts a.duplicable? # true

# .deep_dup will create a deep copy of an object.
a = %w[hello ruby]
b = a.dup
b.last.gsub!('ruby', 'rails')
p b                                 # ["hello", "rails"]
p a                                 # ["hello", "rails"]

a = %w[hello ruby]
b = a.deep_dup
b.last.gsub!('ruby', 'rails')
p b                                 # ["hello", "rails"]
p a                                 # ["hello", "ruby"]

# try is used when we want to apply some method if object is not nil. it will return nil if the oject is nil.
a = nil
puts a.try(:gsub)                                  # nil
a = 'Hello Ruby'
puts a.try { |x| x.gsub('Ruby', 'Rails') }         # Hello Rails

# .acts_like? will check that object is acts like a string, date or time class.
'Hello'.acts_like?(:string)             # true
['Hello'].acts_like?(:string)           # false

# to_param will convert object into parameters. it basically runs to_s at backend.
puts 123.to_param                         # "123"
puts 'hello'.to_param                     # "hello"
puts nil.to_param                         # nil
puts true.to_param                        # true
puts false.to_param                       # false
puts [0, true, String].to_param           # "0/true/String"

# to_query method will create a query string of given key.
'krutik'.to_query('name')                 # "name=krutik"
{ c: 3, b: 2, a: 1 }.to_query             # "a=1&b=2&c=3"

# instance_values will return the values of instance variables.
# instance_variable_names will return the instance variables.
class A
  def initialize(a, b)
    @a = a
    @b = b
  end
end
puts A.new(0, 1).instance_values              # {"a"=>0, "b"=>1}
p A.new(0, 1).instance_variable_names         # ["@a", "@b"]

# in? checks if an object is inclded in other object or not.
puts 1.in?([1, 2]) # true

# module_parent returns the nested parents
# module_parent_name returns the parents in string format
# module_parents returns the parent chain in array format
module X
  module Y
    module Z
    end
  end
end

X::Y::Z.module_parent           # X::Y
X::Y::Z.module_parent_name      # "X::Y"
X::Y::Z.module_parents          # [X::Y, X, Object]

# anonymous is used to check that module has a name or not.
N = Module.new
N.name                    # N
N.anonymous?              # true
Module.new.anonymous?     # false

# delegate method is used to forward the methods of associated class.
# let say we have User model which has_one association with Profile class.
#
# class User
#   has_one :profile
# end
#
# for accessing user's profile name, we should use "user.profile.name". same thing can be done using delegate.
#
# class User < ApplicationRecord
#   has_one :profile
#
#   delegate :name, :age, :address to: :profile
# end
#
# now profile name can be accessed using user.name

# class_attribute is used to decalre a variable that can used as a class variable by any of the child classes of a class in which this
# variable is declared.
class A
  class_attribute :x
end

class B < A; end

class C < B; end

A.x = 'hello'
B.x               # "hello"
C.x               # "hello"

# subclasses returns the array of child classes that are directly inheriting the given class.
class C; end
C.subclasses            # []

class B < C; end
C.subclasses            # [B]

class A < B; end
C.subclasses            # [B]

class D < C; end
C.subclasses            # [B, D]

# decendents returns the array of all child classes of the given class.
class C; end
C.descendants           # []

class B < C; end
C.descendants           # [B]

class A < B; end
C.descendants           # [B, A]

class D < C; end
C.descendants           # [B, A, D]

# remove will remove a perticular pattern from a string.
'Hello World'.remove(/Hello /) # "World"

# squish method removes the escape characters.
" \n  Hello\n\r \t World \n".squish # => "Hello World"

# truncate will cut the string after a given length.
'Hello There, this is action support core extension practical.'.truncate(20)                                # "Hello There, this..."
'Hello There, this is action support core extension practical.'.truncate(20, omission: '(continues...)')    # "Hello (continues...)"

# truncate_bytes will cut the string after a given bytesize.
puts '👍👍👍👍'.truncate_bytes(15) # "👍👍👍…"

# truncate_words will cut the string after a given words.
'Hello There, this is action support core extension practical.'.truncate_words(6) # "Hello There, this is action support..."

# starts_with checks the string starts with given substring or not.
# ends_with checks the string ends with given substring or not.
'hello'.starts_with?('he')               # true
'hello'.ends_with?('lo')                 # true

# at will return the character of string located at specified position.
'hello'.at(3)           # l
'hello'.at(-1)          # o

# from return substring from a specified position.
'hello'.from(2) # llo

# to return substring by a specified position.
'hello'.to(2) # hel

# first will return first character
# last will return last character
'hello'.first           # h
'hello'.last            # o

# plularize will return the plural form of the string.
# singularize will return the singular form of the string.
# camelize will return the camel case form of the string.
# underscore will return the undescored form of the string.
# titlize will return the titlized form of the string.
# dasherize will return the dasherized form of the string.
# parameterize will return the parameterized form of the string.
# tablize will return the tablized form of the string for database table name.
# classify is inverse of tablize.
# humanize will return the humanized form of the string.
# foreign_key will return the foreign_key form of the string.
'table'.plularize                   # "tables"
'tables'.singularize                # "table"
'tables'.camelize                   # "Tables"
'backoffice/session'.camelize       # "Backoffice::Session"
'Product'.underscore                # "product"
'AdminUser'.underscore              # "admin_user"
'alice in wonderland'.titleize      # "Alice In Wonderland"
'name'.dasherize                    # "name"
'contact_data'.dasherize            # "contact-data"
'John Smith'.parameterize           # "john-smith"
'Person'.tableize                   # "people"
'Invoice'.tableize                  # "invoices"
'people'.classify                   # "Person"
'invoices'.classify                 # "Invoice"
'name'.humanize                     # "Name"
'author_id'.humanize                # "Author"
'InvoiceLine'.foreign_key           # "invoice_line_id"
'Admin::Session'.foreign_key        # "session_id"

# to_date will convert into date
# to_time will convert into time. it can have timezone as an argument (utc & local)
# to_datetime will convert into datetime
'2010-07-27'.to_date                  # Tue, 27 Jul 2010
'2010-07-27 23:37:00'.to_time         # 2010-07-27 23:37:00 +0200
'2010-07-27 23:37:00'.to_datetime     # Tue, 27 Jul 2010 23:37:00 +0000
'2010-07-27 23:42:00'.to_time(:utc)   # => 2010-07-27 23:42:00 UTC
'2010-07-27 23:42:00'.to_time(:local) # => 2010-07-27 23:42:00 +0530

2.kilobytes   # 2048
3.megabytes   # 3145728
3.5.gigabytes # 3758096384

1.day.from_now                      # 2023-06-21 18:05:55.941921972 +0530
2.hours.from_now                    # 2023-06-20 20:05:55.954510958 +0530
10.minutes.from_now                 # 2023-06-20 18:15:55.972473995 +0530
3.weeks.from_now                    # 2023-07-11 18:06:42.353752709 +0530
(4.days + 5.weeks).from_now         # 2023-07-29 18:06:59.702215465 +0530
2.months.from_now                   # 2023-08-20 18:28:27.685097449 +0530
2.years.from_now                    # 2025-06-20 18:28:41.700428572 +0530

1_235_551_234.to_fs(:phone, country_code: 91)                                       # +91-123-555-1234
1_234_567_890.501236.to_fs(:currency, precision: 3)                                 # $1,234,567,890.501
1000.231856.to_fs(:percentage, precision: 3, delimiter: '.', separator: ',')        # 1.000,232%
12_345_678.05.to_fs(:delimited, delimiter: '.', separator: '-')                     # 12.345.678-05
111.2345.to_fs(:rounded, precision: 2)                                              # 111.23
1_234_567_890_123.to_fs(:human_size)                                                    # 1.12 TB
1_234_567_890_123.to_fs(:human)                                                         # 1.23 Trillion

# multiple_of? will check if an integer is multiple of the argument.
15.multiple_of?(3)                                  # true
15.multiple_of?(6)                                  # false

# ordinal will return ordinal suffix string of an integer.
1.ordinal                                           # "st"
2.ordinal                                           # "nd"
53.ordinal                                          # "rd"
2009.ordinal                                        # "th"

# ordinalize will return ordinalized suffix string of an integer.
1.ordinalize                                        # "1st"
2.ordinalize                                        # "2nd"
53.ordinalize                                       # "53rd"
2009.ordinalize                                     # "2009th"

# sum method is used to adds the element oof an enumerable
[1, 2, 3].sum                                 # 6
[1, 2].sum(5)                                 # 8
(1..10).sum                                   # 55
[[1, 2], [2, 3], [3, 4]].sum                  # [1, 2, 2, 3, 3, 4]
['Hello', ' ', 'Ruby'].sum                    # "Hello Ruby"
(1..5).sum { |n| n * 2 }                      # 30
[].sum                                        # 0

# index_by is used to generate the hash by given keys and values.
[1, 2, 3].index_by { |x| "#{x + 1}" } # {"2"=>1, "3"=>2, "4"=>3}
# Now lets consider that we have Article model and we want to generate a hash that has
# atricle title as key and article object as value then we can do it by following syntax.
# Article.all.index_by(&:title)

# many? checks collection size is greater than one or not.
[1].many?             # false
[1, 2].many?          # true

# exclude?() checks whether a given object is not belong to the collection.
[1, 2].exclude?(3)    # true
[1, 2].exclude?(2)    # false

# including will include new enumerables to the existing one.
[1, 2, 3].including('hello', 5) # [1, 2, 3, "hello", 5]

# excluding will exclude new enumerables to the existing one.
[1, 2, 3].excluding(1, 3) # [2]

# pluck extract the given key from each element.
[{ id: 1, name: 'David' }, { id: 2, name: 'Rafael' }].pluck(:name) # ["David", "Rafael"]

# pluck extract the given key from first element.
[{ id: 1, name: 'David' }, { id: 2, name: 'Rafael' }].pluck(:name) # "David"

# to will return an array from starting to the given position.
# from will return an entire array strating from given position.
[1, 2, 3, 4].to(2) # [1,2,3]
[1, 2, 3, 4].from(2) # [3, 4]

# extract removes the element and return them which follows the given condition.
numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
odd_numbers = numbers.extract! { |number| number.odd? }
numbers                                     # [0, 2, 4, 6, 8]
odd_numbers                                 # [1, 3, 5, 7, 9]

# to_sentence will convert the array elements into readable string.
%w[Ruby Rails].to_sentence # "Ruby and Rails"

# Array.wrap() is used to wrap its argument into an array unless it is already an array.
Array.wrap(nil)                   # => []
Array.wrap([1, 2, 3])             # => [1, 2, 3]
Array.wrap(0)                     # => [0]

# in_groups_of is used to group the array into the groups of number of elements given as an argument.
[1, 2, 3].in_groups_of(2)             # [[1, 2], [3, nil]]
[1, 2, 3].in_groups_of(2, false)      # [[1, 2], [3]]
[1, 2, 3].in_groups_of(2, 5)          # [[1, 2], [3, 5]]

# in_groups is used to group the array into a number of group given in an argument.
[1, 2, 3, 4, 5, 6, 7].in_groups(3)          # [[1, 2, 3], [4, 5, nil], [6, 7, nil]]
[1, 2, 3, 4, 5, 6, 7].in_groups(3, false)   # [[1, 2, 3], [4, 5], [6, 7]]
[1, 2, 3, 4, 5, 6, 7].in_groups(3, 15)      # [[1, 2, 3], [4, 5, 15], [6, 7, 15]]

# split() will divide an array by a given saperator.
[0, 1, -5, 1, 1, 'foo', 'bar'].split(1)             # [[0], [-5], [], ["foo", "bar"]]
(1..10).to_a.split { |x| x.multiple_of?(3) }        # [[1, 2], [4, 5], [7, 8], [10]]

# merge will be used to merge two hashes.
# reverse_merge will be used to reversly merge two hashes.
{ a: 1, b: 1 }.merge(c: 2, d: 2)                    # {:a=>1, :b=>1, :c=>2, :d=>2}
{ a: 1, b: 1 }.reverse_merge(c: 2, d: 2)            # {:c=>2, :d=>2, :a=>1, :b=>1}
{ a: { b: 1 } }.deep_merge(a: { c: 2 })             # {:a=>{:b=>1, :c=>2}}

# except returns a hash with the key given in the argument.
{ a: 1, b: 2 }.except(:a) # {:b=>2}

# stringify_keys returns the hash of a stringified version of keys.
{ 'a' => 1, a: 2 }.stringify_keys                               # {"a"=>2}
{ nil => nil, 1 => 1, a: :a, "kp": 'sp' }.stringify_keys        # {""=>nil, "1"=>1, "a"=>:a, "kp"=>"sp"}

# symbolize_keys returns the hash of a symbolized version of keys.
{ 'a' => 1, a: 2 }.symbolize_keys                               # {:a=>2}
{ nil => nil, 1 => 1, a: :a, "kp": 'sp' }.stringify_keys        # {nil=>nil, 1=>1, :a=>:a, :kp=>"sp"}

# deep_transform_values returns the hash which has values transformed by the given block execution.
# {:person=>{:name=>"ROB", :age=>"28"}}
{ person: { name: 'Rob', age: '28' } }.deep_transform_values do |value|
  value.to_s.upcase
end
# slice! will removes the specified key and returns the remaining hash.
# extract! will removes the specified key and returns the removed key hash.
{ a: 1, b: 2 }.slice!(:a) # {:b=>2}
{ a: 1, b: 2 }.extract!(:a) # {:a=>1}

# .with_indifferent_access will allow user to make hash values accessible with different types of strings.
h = { a: 1 }
h[:a]                             # 1
h['a']                            # nil
h = { a: 1 }.with_indifferent_access
h[:a]                             # 1
h['a']                            # 1

# === and include? will be used to check if given range included inside other given string.
(1..10).include?((3..7))                # true
(1..10).include?((0..7))                # false
(1..10).include?(3..7)                  # true
(1..10).include?(0..7)                  # false

# overlaps? will check whether two ranges overlaps with each other or not.
(1..10).overlaps?(0..7)                 # true
(1..10).overlaps?(11..27)               # false

# Date.current will return today's date in current time zone.
d = Date.current                          # Wed, 21 Jun 2023
d.beginning_of_week                       # Mon, 19 Jun 2023
d.end_of_week                             # Sun, 25 Jun 2023
d.monday                                  # Mon, 19 Jun 2023
d.sunday                                  # Sun, 25 Jun 2023
d.next_week                               # Mon, 26 Jun 2023
d.next_week(:wednesday)                   # Wed, 28 Jun 2023
d.prev_week                               # Mon, 12 Jun 2023
d.beginning_of_month                      # Thu, 01 Jun 2023
d.end_of_month                            # Fri, 30 Jun 2023
d.beginning_of_quarter                    # Sat, 01 Apr 2023
d.end_of_quarter                          # Fri, 30 Jun 2023
d.beginning_of_year                       # Sun, 01 Jan 2023
d.end_of_year                             # Sun, 31 Dec 2023
d.years_ago(10)                           # Fri, 21 Jun 2013
d.years_since(10)                         # Tue, 21 Jun 2033
d.months_ago(10)                          # Sun, 21 Aug 2022
d.months_since(10)                        # Sun, 21 Apr 2024
d.weeks_ago(2)                            # Wed, 07 Jun 2023
d.weeks_since(2)                          # Wed, 05 Jul 2023
d.advance(years: 2, weeks: 4, days: -2)   # Thu, 17 Jul 2025
d + 1.years                               # Fri, 21 Jun 2024
d + 5.hours                               # 2023-06-21 05:00:00 +0530
d.beginning_of_day                        # 2023-06-21 00:00:00 +0530
d.end_of_day                              # 2023-06-21 23:59:59.999999999 +0530

# DateTime Operations.
now = DateTime.current                                                            # Thu, 22 Jun 2023 10:13:26 +0530
now.utc?                                                                          # false
now.utc                                                                           # 2023-06-22 04:43:26.678398435 UTC
now.advance(years: 1, months: 1, days: 1, hours: 1, minutes: 1, seconds: 1)       # Tue, 23 Jul 2024 11:14:27 +0530
now.change(year: 2025, offset: Rational(7, 24))                                   # Sun, 22 Jun 2025 10:13:26 +0700

# Time Operations.
t = Time.local(2010, 3, 28, 1, 59, 59)                # 2010-03-28 01:59:59 +0530
t.advance(seconds: 1)                                 # 2010-03-28 02:00:00 +0530
t.all_day                                             # 2010-03-28 00:00:00 +0530..2010-03-28 23:59:59.999999999 +0530
t.all_week                                            # 2010-03-22 00:00:00 +0530..2010-03-28 23:59:59.999999999 +0530
t.all_week(:wednesday)                                # 2010-03-24 00:00:00 +0530..2010-03-30 23:59:59.999999999 +0530
t.all_year                                            # 2010-01-01 00:00:00 +0530..2010-12-31 23:59:59.999999999 +0530
t.all_month                                           # 2010-03-01 00:00:00 +0530..2010-03-31 23:59:59.999999999 +0530
t.all_quarter                                         # 2010-01-01 00:00:00 +0530..2010-03-31 23:59:59.999999999 +0530
t.prev_day                                            # 2010-03-27 01:59:59 +0530
t.prev_month                                          # 2010-02-28 01:59:59 +0530
t.prev_year                                           # 2009-03-28 01:59:59 +0530
t.prev_week                                           # 2010-03-15 00:00:00 +0530
t.prev_quarter                                        # 2009-12-28 01:59:59 +0530
t.next_day                                            # 2010-03-29 01:59:59 +0530
t.next_month                                          # 2010-04-28 01:59:59 +0530
t.next_year                                           # 2011-03-28 01:59:59 +0530
t.next_week                                           # 2010-03-29 00:00:00 +0530
t.next_quarter                                        # 2010-06-28 01:59:59 +0530
t + 1.year                                            # 2011-03-28 01:59:59 +0530
