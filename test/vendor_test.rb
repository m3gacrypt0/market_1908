require 'minitest/autorun'
require 'minitest/pride'
require './lib/vendor'

class VendorTest < Minitest::Test

  def setup
    @vendor = Vendor.new("Rocky Mountain Fresh")
  end

  def test_it_exists
    assert_instance_of Vendor, @vendor
  end

  def test_it_has_initial_attributes
    assert_equal "Rocky Mountain Fresh", @vendor.name
    assert_equal ({}), @vendor.inventory
  end

  def test_method_check_stock
    assert_equal 0, @vendor.check_stock("Peaches")
    @vendor.stock("Peaches", 30)
    assert_equal 30, @vendor.check_stock("Peaches")
    @vendor.stock("Peaches", 25)
    assert_equal 55, @vendor.check_stock("Peaches")
    @vendor.stock("Tomatoes", 12)
    assert_equal 12, @vendor.check_stock("Tomatoes")
  end

  def test_inventory_attribute_after_initial
    @vendor.stock("Peaches", 30)
    assert_equal ({"Peaches" => 30}), @vendor.inventory
    @vendor.stock("Peaches", 25)
    assert_equal ({"Peaches" => 55}), @vendor.inventory
    @vendor.stock("Tomatoes", 12)
    assert_equal ({"Peaches" => 55, "Tomatoes" => 12}), @vendor.inventory
  end

end
