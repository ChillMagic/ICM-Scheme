# Library
## Bitset

### =
[(x : Bitset) (rest : Bitset ...)] -> Boolean

### and
[(x : Bitset) (rest : Bitset ...)] -> Bitset

### not
[(x : Bitset)] -> Bitset

### or
[(x : Bitset) (rest : Bitset ...)] -> Bitset

### xor
[(x : Bitset) (rest : Bitset ...)] -> Bitset

## Boolean

### =
[(x : Boolean) (rest : Boolean ...)] -> Boolean

### and
[(x : Boolean) (rest : Boolean ...)] -> Boolean

### not
[(x : Boolean)] -> Boolean

### or
[(x : Boolean) (rest : Boolean ...)] -> Boolean

### xor
[(x : Boolean) (rest : Boolean ...)] -> Boolean

## List

### +
[(x : List) (rest : List ...)] -> List

### reserve
[(x : List)] -> List

### sort
[(x : List) (f : (Function [a b] -> Boolean))] -> List

## Number

### *
[(x : Number) (rest : Number ...)] -> Number

### +
[(x : Number) (rest : Number ...)] -> Number

### -
[(x : Number) (rest : Number ...)] -> Number

### ->String
[(x : Number)] -> Number

### /
[(x : Number) (rest : Number ...)] -> Number

### <
[(x : Number) (rest : Number ...)] -> Boolean

### <=
[(x : Number) (rest : Number ...)] -> Boolean

### =
[(x : Number) (rest : Number ...)] -> Boolean

### >
[(x : Number) (rest : Number ...)] -> Boolean

### >=
[(x : Number) (rest : Number ...)] -> Boolean

### abs
[(x : Number)] -> Number

### dec
[(x : Number)] -> Number

### gcd
[(x : Number) (y : Number)] -> Number

### inc
[(x : Number)] -> Number

### mod
[(x : Number) (y : Number)] -> Number

### rem
[(x : Number) (y : Number)] -> Number

## String

### +
[(x : String) (rest : String ...)] -> String

### ->List
[(str : String)] -> List

### ->Number
[(str : String)] -> Number

### ->Symbol
[(str : String)] -> Symbol

### sub
[(str : String) (id : Integer) (len : Integer)] -> String

## Symbol

### ->String
[(sym : Symbol)] -> String

## System

### print
[(any : Vary) (rest : Vary ...)] -> List

### println
[(any : Vary) (rest : Vary ...)] -> List

### system
[(cmd : String)] -> Integer

