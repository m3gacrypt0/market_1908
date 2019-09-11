class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    output = []
    @vendors.each {|vendor| output << vendor.name}
    output
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.inventory.has_key?(item)
    end
  end

  def sorted_item_list
    output = []
    @vendors.each do |vendor|
      vendor.inventory.each_pair do |item, _|
        output << item if output.include?(item) == false
      end
    end
    output.sort
  end

  def total_inventory
    output = Hash.new(0)
    @vendors.each do |vendor|
      vendor.inventory.each_pair do |item, quantity|
        output[item] += quantity
      end
    end
    output
  end

  def sell(item_desired, quantity_desired)

    if total_inventory[item_desired] < quantity_desired
      return false
    else
      debit_quantity = quantity_desired
      @vendors.each do |vendor|
        vendor.inventory.each_pair do |item, quantity|
          if item == item_desired
            if debit_quantity <= quantity
              vendor.inventory[item] -= debit_quantity
            else
              vendor.inventory[item] = 0
              debit_quantity -= quantity
            end
          end
        end
    end

    true
    end
  end

end
