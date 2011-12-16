require 'test/unit'
require 'bookworm'

class BookwormTest < Test::Unit::TestCase
  def setup
    @bookworm = Bookworm.new('9780976805427')
  end

  def test_should_scrub_inputs
    @bookworm.scrub('9780976805427999990')
  end

  def test_should_calculate_thirteen_check_digit
    assert_equal "6", @bookworm.thirteen_check_digit('2900976805426')
  end

  def test_should_calculate_ten_check_digit
    assert_equal "1", @bookworm.ten_check_digit("0976805421")
  end

  def test_should_create_from_used
    assert_equal '9780976805427', Bookworm.new("2900976805426").isbn
  end
  
  def test_should_convert_from_ten
    assert_equal '9780976805427', Bookworm.new("0976805421").as_new
    assert_equal '9780073324920', Bookworm.new("0073324922").as_new
  end

  def test_should_convert_to_new
    assert_equal "9780976805427", @bookworm.as_new
  end

  def test_should_convert_to_used
    assert_equal "2900976805426", @bookworm.as_used
  end

  def test_should_convert_to_ten
    assert_equal "0976805421", @bookworm.as_ten
  end

  def test_should_convert_to_new_from_979
    assert_equal "9790883590569", Bookworm.new('9790883590569').as_new
  end

  def test_should_convert_to_used_from_979
    assert_equal "2910883590568", Bookworm.new('9790883590569').as_used
  end

  def test_should_not_convert_from_979_to_ten
    assert_nil Bookworm.new('9790883590569').as_ten
  end

  def test_should_mark_invalid_bad_isbns
    assert_equal false, Bookworm.new('9790883590562').is_valid?
    assert_equal false, Bookworm.new('herpderp').is_valid?
    assert_equal false, Bookworm.new('978herpderp').is_valid?
  end

  def test_should_not_mark_valid_isbns_as_invalid
    assert_equal true, @bookworm.is_valid?
  end

  def test_should_return_nil_if_invalid_string_used
    assert_nil Bookworm.new('herpderp').as_new
    assert_nil Bookworm.new('herpderp').as_used
    assert_nil Bookworm.new('herpderp').as_ten
  end

  def test_should_have_original_type
    assert_equal 'used', Bookworm.new("2900976805426").type
    assert_equal 'used', Bookworm.new('979088359056290000').type
    assert_equal 'used', Bookworm.new("290097680542690000").type
    assert_equal 'new',  Bookworm.new("290097680542699990").type
    assert_equal 'new',  Bookworm.new("0976805421").type
  end
end