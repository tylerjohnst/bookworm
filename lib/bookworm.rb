class Bookworm
  attr_reader :isbn, :original

  def initialize(identifier)
    @original = identifier.to_s
    @isbn = as_new(identifier.to_s)
    @type = type
  end

  def as_new(identifier=isbn)
    return nil unless identifier
    identifier = scrub(identifier)
    case identifier
    when /^290/ then to_thirteen("978#{identifier[3..-1]}")
    when /^291/ then to_thirteen("979#{identifier[3..-1]}")
    when /^979|978|\d{10}/ then to_thirteen(identifier)
    else nil
    end
  end

  def as_used
    return nil unless is_valid?
    prefix = /^979/.match(isbn) ? "291" : "290"
    to_thirteen(prefix + isbn[3..-1])
  end

  def as_ten
    return nil if not is_valid? or isbn =~ /979/
    identifier = isbn[3..-2]
    identifier + ten_check_digit(identifier)
  end

  def type
    addendum = case original
    when /^(?:978|979)\d{10}/
      addendum = /^(?:978|979)\d{10}(\d{5})$/.match(original).to_a.last
      addendum == '90000' ? 'used' : 'new'
    when /^(?:290|291)\d{10}/
      addendum = /^(?:290|291)\d{10}(\d{5})$/.match(original).to_a.last
      addendum == '99990' ? 'new' : 'used'
    when /^\d{10}$/
      'new'
    else nil
    end
  end

  def to_thirteen(identifier)
    identifier = strip_last(identifier)
    identifier + thirteen_check_digit(identifier)
  end

  def scrub(string)
    result = /^((?:978|979|291|290)\d{10}|\d{10}).*/.match(string.delete('-'))
    result ? result[1] : nil
  end

  def thirteen_check_digit(identifier)
    sum = 0
    12.times do |index|
      digit = identifier[index].to_i
      sum += index.even? ? digit : digit * 3
    end
    checksum = (10 - sum % 10)
    checksum == 10 ? '0' : checksum.to_s
  end

  def ten_check_digit(identifier)
    sum = 0
    9.times do |index|
      sum += (10 - index) * identifier[index].to_i
    end
    checksum = 11 - sum % 11

    case checksum
    when 10 then "X"
    when 11 then "0"
    else checksum.to_s
    end
  end

  def is_valid?
    !!(isbn && isbn[-1] == original[-1])
  end

  def strip_last(string)
    string.rjust(13,"978")[/(.+)\w/,1]
  end
end