# Bookworm

Your wiggling friend in ISBN conversions.

```
@book = Bookworm.new('9780980011111')

@book.as_new
> "9780980011111"
@book.as_used
> "2900980011110"
@book.as_ten
> "0980011116"
@book.valid?
> true
```