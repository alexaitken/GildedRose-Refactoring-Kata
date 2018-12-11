import { expect } from 'chai';
import { Item, GildedRose } from '../app/gilded-rose';

describe('Gilded Rose', function () {
  it('should foo', function() {
    const gildedRose = new GildedRose([ new Item('foo', 0, 0) ]);
    const items = gildedRose.updateQuality();
    expect(items[0].name).to.equal('foo');
  });

  context('Normal Item', function() {
    it('before sell date', function() {
      const gildedRose = new GildedRose([new Item('Normal Item', 5, 10)]);

      const items = gildedRose.updateQuality();

      expect(items[0]).to.include({ sellIn: 4, quality: 9 });
    });

    it('on sell date', function() {
      const gildedRose = new GildedRose([new Item('Normal Item', 0, 10)]);

      const items = gildedRose.updateQuality();

      expect(items[0]).to.include({ sellIn: -1, quality: 8 });
    });

    it('after sell date', function() {
      const gildedRose = new GildedRose([new Item('Normal Item', -10, 10)]);

      const items = gildedRose.updateQuality();

      expect(items[0]).to.include({ sellIn: -11, quality: 8 });
    });

    it('of zero quality', function() {
      const gildedRose = new GildedRose([new Item('Normal Item', 5, 0)]);

      const items = gildedRose.updateQuality();

      expect(items[0]).to.include({ sellIn: 4, quality: 0 });
    });
  });

  context('Aged Brie', function() {
    it('before sell date', function() {
      const gildedRose = new GildedRose([new Item('Aged Brie', 5, 10)]);

      const items = gildedRose.updateQuality();

      expect(items[0]).to.include({ sellIn: 4, quality: 11 });
    });

    it('with max quality', function() {
      const gildedRose = new GildedRose([new Item('Aged Brie', 5, 50)]);

      const items = gildedRose.updateQuality();

      expect(items[0]).to.include({ sellIn: 4, quality: 50 });
    });

    it('on sell date', function() {
      const gildedRose = new GildedRose([new Item('Aged Brie', 0, 10)]);

      const items = gildedRose.updateQuality();

      expect(items[0]).to.include({ sellIn: -1, quality: 12 });
    });

    it('on sell date near max quality', function() {
      const gildedRose = new GildedRose([new Item('Aged Brie', 0, 49)]);

      const items = gildedRose.updateQuality();

      expect(items[0]).to.include({ sellIn: -1, quality: 50 });
    });

    it('on sell date with max quality', function() {
      const gildedRose = new GildedRose([new Item('Aged Brie', 0, 50)]);

      const items = gildedRose.updateQuality();

      expect(items[0]).to.include({ sellIn: -1, quality: 50 });
    });

    it('after sell date', function() {
      const gildedRose = new GildedRose([new Item('Aged Brie', -10, 10)]);

      const items = gildedRose.updateQuality();

      expect(items[0]).to.include({ sellIn: -11, quality: 12 });
    });

    it('after sell date with max quality', function() {
      const gildedRose = new GildedRose([new Item('Aged Brie', -10, 50)]);

      const items = gildedRose.updateQuality();

      expect(items[0]).to.include({ sellIn: -11, quality: 50 });
    });
  });

  context('Sulfuras', function() {
    it('before sell date', function() {
      const gildedRose = new GildedRose([new Item('Sulfuras, Hand of Ragnaros', 5, 80)]);

      const items = gildedRose.updateQuality();

      expect(items[0]).to.include({ sellIn: 5, quality: 80 });
    });

    it('on sell date', function() {
      const gildedRose = new GildedRose([new Item('Sulfuras, Hand of Ragnaros', 0, 80)]);

      const items = gildedRose.updateQuality();

      expect(items[0]).to.include({ sellIn: 0, quality: 80 });
    });

    it('after sell date', function() {
      const gildedRose = new GildedRose([new Item('Sulfuras, Hand of Ragnaros', -10, 80)]);

      const items = gildedRose.updateQuality();

      expect(items[0]).to.include({ sellIn: -10, quality: 80 });
    });
  });

  context('Backstage Pass', function() {
    it('long before sell date', function() {
      const gildedRose = new GildedRose([new Item('Backstage passes to a TAFKAL80ETC concert', 11, 10)]);

      const items = gildedRose.updateQuality();

      expect(items[0]).to.include({ sellIn: 10, quality: 11 });
    });

    it('long before sell date at max quality', function() {
      const gildedRose = new GildedRose([new Item('Backstage passes to a TAFKAL80ETC concert', 11, 50)]);

      const items = gildedRose.updateQuality();

      expect(items[0]).to.include({ sellIn: 10, quality: 50 });
    });

    it('medium close to sell date upper bound', function() {
      const gildedRose = new GildedRose([new Item('Backstage passes to a TAFKAL80ETC concert', 10, 10)]);

      const items = gildedRose.updateQuality();

      expect(items[0]).to.include({ sellIn: 9, quality: 12 });
    });

    it('medium close to sell date upper bound at max quality', function() {
      const gildedRose = new GildedRose([new Item('Backstage passes to a TAFKAL80ETC concert', 10, 50)]);

      const items = gildedRose.updateQuality();

      expect(items[0]).to.include({ sellIn: 9, quality: 50 });
    });

    it('medium close to sell date lower bound', function() {
      const gildedRose = new GildedRose([new Item('Backstage passes to a TAFKAL80ETC concert', 6, 10)]);

      const items = gildedRose.updateQuality();

      expect(items[0]).to.include({ sellIn: 5, quality: 12 });
    });

    it('medium close to sell date lower bound at max quality', function() {
      const gildedRose = new GildedRose([new Item('Backstage passes to a TAFKAL80ETC concert', 6, 50)]);

      const items = gildedRose.updateQuality();

      expect(items[0]).to.include({ sellIn: 5, quality: 50 });
    });

    it('very close to sell date upper bound', function() {
      const gildedRose = new GildedRose([new Item('Backstage passes to a TAFKAL80ETC concert', 5, 10)]);

      const items = gildedRose.updateQuality();

      expect(items[0]).to.include({ sellIn: 4, quality: 13 });
    });

    it('very close to sell date upper bound at max quality', function() {
      const gildedRose = new GildedRose([new Item('Backstage passes to a TAFKAL80ETC concert', 5, 50)]);

      const items = gildedRose.updateQuality();

      expect(items[0]).to.include({ sellIn: 4, quality: 50 });
    });

    it('very close to sell date lower bound', function() {
      const gildedRose = new GildedRose([new Item('Backstage passes to a TAFKAL80ETC concert', 1, 10)]);

      const items = gildedRose.updateQuality();

      expect(items[0]).to.include({ sellIn: 0, quality: 13 });
    });

    it('very close to sell date lower bound at max quality', function() {
      const gildedRose = new GildedRose([new Item('Backstage passes to a TAFKAL80ETC concert', 1, 50)]);

      const items = gildedRose.updateQuality();

      expect(items[0]).to.include({ sellIn: 0, quality: 50 });
    });

    it('on sell date', function() {
      const gildedRose = new GildedRose([new Item('Backstage passes to a TAFKAL80ETC concert', 0, 10)]);

      const items = gildedRose.updateQuality();

      expect(items[0]).to.include({ sellIn: -1, quality: 0 });
    });

    it('after sell date', function() {
      const gildedRose = new GildedRose([new Item('Backstage passes to a TAFKAL80ETC concert', -10, 10)]);

      const items = gildedRose.updateQuality();

      expect(items[0]).to.include({ sellIn: -11, quality: 0 });
    });
  });

  context('Conjured Mana', function() {
    xit('before sell date', function() {
      const gildedRose = new GildedRose([new Item('Conjured Mana Cake', 5, 10)]);

      const items = gildedRose.updateQuality();

      expect(items[0]).to.include({ sellIn: 4, quality: 8 });
    });

    xit('before sell date at zero quality', function() {
      const gildedRose = new GildedRose([new Item('Conjured Mana Cake', 5, 0)]);

      const items = gildedRose.updateQuality();

      expect(items[0]).to.include({ sellIn: 4, quality: 0 });
    });

    xit('on sell date', function() {
      const gildedRose = new GildedRose([new Item('Conjured Mana Cake', 0, 10)]);

      const items = gildedRose.updateQuality();

      expect(items[0]).to.include({ sellIn: -1, quality: 6 });
    });

    xit('on sell date at zero quality', function() {
      const gildedRose = new GildedRose([new Item('Conjured Mana Cake', 0, 0)]);

      const items = gildedRose.updateQuality();

      expect(items[0]).to.include({ sellIn: -1, quality: 0 });
    });

    xit('after sell date', function() {
      const gildedRose = new GildedRose([new Item('Conjured Mana Cake', -10, 10)]);

      const items = gildedRose.updateQuality();

      expect(items[0]).to.include({ sellIn: -11, quality: 6 });
    });

    xit('after sell date at zero quality', function() {
      const gildedRose = new GildedRose([new Item('Conjured Mana Cake', -10, 0)]);

      const items = gildedRose.updateQuality();

      expect(items[0]).to.include({ sellIn: -11, quality: 0 });
    });
  });
});
