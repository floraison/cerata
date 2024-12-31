
# cerata

[![tests](https://github.com/floraison/cerata/workflows/test/badge.svg)](https://github.com/floraison/cerata/actions)
[![Gem Version](https://badge.fury.io/rb/cerata.svg)](https://badge.fury.io/rb/cerata)

Tabula cerata formatting for floraison and flor, data to string formatting.

## `Cerata.horizontal_a_to_s(array, indent='')`

TODO

## `Cerata.horizontal_h_to_s(hash, indent='')`

TODO

## `Cerata.vertical_h_to_s(hash, indent='')`

TODO

## `Cerata.table_to_s(array_of_hashes, indent='')`

```ruby
require 'cerata'

a = [
  { name: 'Haddock', age: 52 },
  { name: 'Tintin', age: 31, weight: 60 },
  { name: 'Castafiore', id: 123, age: 59, height: 163 },
  { name: 'Milou', id: 12, age: 3, height: 20 } ]

puts Cerata.table_to_s(a)
  # =>
%{
[
{ name: "Haddock"   , age: 52,                                  },
{ name: "Tintin"    , age: 31, weight: 60,                      },
{ name: "Castafiore", age: 59,             id: 123, height: 163 },
{ name: "Milou"     , age:  3,             id:  12, height:  20 },
]
}
```


## LICENSE

MIT, see [LICENSE.txt](LICENSE.txt)

