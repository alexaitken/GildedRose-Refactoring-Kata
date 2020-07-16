require File.join(File.dirname(__FILE__), 'gilded_rose')
require 'minitest/autorun'

class GildedRoseNormalItemTest <  Minitest::Test
  def setup
    @initial_sell_in = 5
    @initial_quality = 10
    @name = "NORMAL ITEM"
  end

  def execute
    @item = Item.new(@name, @initial_sell_in, @initial_quality)
    @subject = GildedRose.new([@item])
    @subject.update_quality
  end

  def test_reduces_sell_in_by_1
    execute
    assert_equal(@initial_sell_in - 1, @item.sell_in)
  end

  def test_before_sell_date_reduces_quality_by_1
    execute
    assert_equal(@initial_quality - 1, @item.quality)
  end

  def test_on_sell_date_reduces_quality_by_2
    @initial_sell_in = 0
    execute
    assert_equal(@initial_quality - 2, @item.quality)
  end

  def test_after_sell_date_reduces_quality_by_2
    @initial_sell_in = -10
    execute
    assert_equal(@initial_quality - 2, @item.quality)
  end

  def test_after_sell_date_of_zero_quality_will_not_reduce_the_quality_below_0
    @initial_sell_in = -10
    @initial_quality = 0
    execute
    assert_equal(0, @item.quality)
  end
end

class GildedRoseAgedBrieTest < Minitest::Test
  def setup
    @initial_sell_in = 5
    @initial_quality = 10
    @name = "Aged Brie"
  end

  def execute
    @item = Item.new(@name, @initial_sell_in, @initial_quality)
    @subject = GildedRose.new([@item])
    @subject.update_quality
  end

  def test_reduces_sell_in_by_1
    execute
    assert_equal(@initial_sell_in - 1, @item.sell_in)
  end

  def test_before_sell_date_increase_quality_by_1
    execute
    assert_equal(@initial_quality + 1, @item.quality)
  end

  def test_before_sell_date_with_max_quality_will_not_increase_quality_above_maximum
    @initial_quality = 50
    execute
    assert_equal(50, @item.quality)
  end

  def test_on_sell_date_increases_quality_by_2
    @initial_sell_in = 0
    execute
    assert_equal(@initial_quality + 2, @item.quality)
  end

  def test_on_sell_date_near_max_quality_will_not_increase_quality_above_maximum
    @initial_sell_in = 0
    @initial_quality = 49
    execute
    assert_equal(50, @item.quality)
  end

  def test_on_sell_date_with_max_quality_will_not_increase_quality_above_maximum
    @initial_sell_in = 0
    @initial_quality = 50
    execute
    assert_equal(50, @item.quality)
  end

  def test_after_sell_date_increases_quality_by_2
    @initial_sell_in = -10
    execute
    assert_equal(@initial_quality + 2, @item.quality)
  end

  def test_after_sell_date_with_max_quality_will_not_increase_quality_above_maximum
    @initial_sell_in = -10
    @initial_quality = 50
    execute
    assert_equal(50, @item.quality)
  end
end

class GildedRoseSulfurasTest < Minitest::Test
  def setup
    @initial_sell_in = 5
    @initial_quality = 80
    @name = "Sulfuras, Hand of Ragnaros"
  end

  def execute
    @item = Item.new(@name, @initial_sell_in, @initial_quality)
    @subject = GildedRose.new([@item])
    @subject.update_quality
  end

  def test_does_not_change_sell_in
    execute
    assert_equal(@initial_sell_in, @item.sell_in)
  end

  def test_before_sell_date_does_not_change_quality
    @initial_sell_in = 5
    execute
    assert_equal(@initial_quality, @item.quality)
  end

  def test_on_sell_date_does_not_change_quality
    @initial_sell_in = 0
    execute
    assert_equal(@initial_quality, @item.quality)
  end

  def test_after_sell_date_does_not_change_quality
    @initial_sell_in = -10
    execute
    assert_equal(@initial_quality, @item.quality)
  end
end

class GildedRoseBackstagePassTest < Minitest::Test
  def setup
    @initial_sell_in = 5
    @initial_quality = 10
    @name = "Backstage passes to a TAFKAL80ETC concert"
  end

  def execute
    @item = Item.new(@name, @initial_sell_in, @initial_quality)
    @subject = GildedRose.new([@item])
    @subject.update_quality
  end

  def test_reduces_sell_in_by_1
    execute
    assert_equal(@initial_sell_in - 1, @item.sell_in)
  end

  def test_long_before_sell_date_increases_quality_by_1
    @initial_sell_in = 11
    execute
    assert_equal(@initial_quality + 1, @item.quality)
  end

  def test_long_before_sell_date_at_max_quality_will_not_increase_quality_above_maximum
    @initial_sell_in = 11
    @initial_quality = 50

    execute
    assert_equal(50, @item.quality)
  end

  def test_medium_close_to_sell_date_upper_bound_increases_quality_by_2
    @initial_sell_in = 10
    execute
    assert_equal(@initial_quality + 2, @item.quality)
  end

  def test_medium_close_to_sell_date_upper_bound_at_max_quality_will_not_increase_quality_above_maximum
    @initial_sell_in = 10
    @initial_quality = 50
    execute
    assert_equal(50, @item.quality)
  end

  def test_medium_close_to_sell_date_lower_bound_increases_quality_by_2
    @initial_sell_in = 6
    execute
    assert_equal(@initial_quality + 2, @item.quality)
  end

  def test_medium_close_to_sell_date_lower_bound_at_max_quality_will_not_increase_quality_above_maximum
    @initial_sell_in = 6
    @initial_quality = 50
    execute
    assert_equal(50, @item.quality)
  end

  def test_very_close_to_sell_date_upper_bound_increases_quality_by_3
    @initial_sell_in = 5
    execute
    assert_equal(@initial_quality + 3, @item.quality)
  end

  def test_very_close_to_sell_date_upper_bound_at_max_quality_will_not_increase_quality_above_maximum
    @initial_sell_in = 5
    @initial_quality = 50
    execute
    assert_equal(50, @item.quality)
  end

  def test_very_close_to_sell_date_lower_bound_increases_quality_by_3
    @initial_sell_in = 1
    execute
    assert_equal(@initial_quality + 3, @item.quality)
  end

  def test_very_close_to_sell_date_lower_bound_at_max_quality_will_not_increase_quality_above_maximum
    @initial_sell_in = 1
    @initial_quality = 50
    execute
    assert_equal(50, @item.quality)
  end

  def test_on_sell_date_quality_drops_to_zero
    @initial_sell_in = 0
    execute
    assert_equal(0, @item.quality)
  end

  def test_after_sell_date_quality_drops_to_zero
    @initial_sell_in = -10
    execute
    assert_equal(0, @item.quality)
  end
end

class GildedRoseConjouredItemPassTest < Minitest::Test
  def setup
    @initial_sell_in = 5
    @initial_quality = 10
    @name = "Conjured Mana Cake"
    skip
  end

  def execute
    @item = Item.new(@name, @initial_sell_in, @initial_quality)
    @subject = GildedRose.new([@item])
    @subject.update_quality
  end

  def test_reduces_sell_in_by_1
    execute
    assert_equal(@initial_sell_in - 1, @item.sell_in)
  end

  def test_before_sell_date_increase_quality_by_2
    @initial_sell_in = 5
    execute
    assert_equal(@initial_quality + 2, @item.quality)
  end

  def test_before_sell_date_at_zero_quality_does_not_increase_quality
    @initial_sell_in = 5
    @initial_quality = 0
    execute
    assert_equal(0, @item.quality)
  end

  def test_on_sell_date_reduces_quality_by_4
    @initial_sell_in = 0
    execute
    assert_equal(@initial_quality - 4, @item.quality)
  end

  def test_on_sell_date_at_zero_quality_does_not_increase_quality
    @initial_sell_in = 0
    @initial_quality = 0
    execute
    assert_equal(0, @item.quality)
  end

  def test_after_sell_date_reduces_quality_by_4
    @initial_sell_in = -10
    execute
    assert_equal(@initial_quality - 4, @item.quality)
  end

  def test_after_sell_date_at_zero_quality_does_not_increase_quality
    @initial_sell_in = -10
    @initial_quality = 0
    execute
    assert_equal(0, @item.quality)
  end
end

class GildedRoseWithSeveralItems < Minitest::Test
  def setup
    @items = [
      Item.new("NORMAL ITEM", 5, 10),
      Item.new("Aged Brie", 3, 10),
    ]
    @subject = GildedRose.new(@items)
    @subject.update_quality
  end

  def test_updates_first_item
    item = @items[0]
    assert_equal(9, item.quality)
    assert_equal(4, item.sell_in)
  end

  def test_updates_second_item
    item = @items[1]
    assert_equal(11, item.quality)
    assert_equal(2, item.sell_in)
  end
end
