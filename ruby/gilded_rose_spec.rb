require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  describe "#update_quality" do
    context "with a single" do
      let(:initial_sell_in) { 5 }
      let(:initial_quality) { 10 }
      let(:item) { Item.new(name, initial_sell_in, initial_quality) }

      subject { described_class.new([item]) }

      before do
        subject.update_quality
      end

      context "normal item" do
        let(:name) { "NORMAL ITEM" }

        it 'reduces sell in by 1' do
          expect(item.sell_in).to eq(initial_sell_in-1)
        end

        context "before sell date" do
          it 'reduces quality by 1' do
            expect(item.quality).to eq(initial_quality-1)
          end
        end

        context "on sell date" do
          let(:initial_sell_in) { 0 }
          it 'reduces quality by 2' do
            expect(item.quality).to eq(initial_quality-2)
          end
        end

        context "after sell date" do
          let(:initial_sell_in) { -10 }
          it 'reduces quality by 2' do
            expect(item.quality).to eq(initial_quality-2)
          end
        end

        context "of zero quality" do
          let(:initial_quality) { 0 }
          it 'will not reduce the quality below 0' do
            expect(item.quality).to eq(0)
          end
        end
      end

      context "Aged Brie" do
        let(:name) { "Aged Brie" }

        it 'reduces sell in by 1' do
          expect(item.sell_in).to eq(initial_sell_in-1)
        end

        context "before sell date" do
          it 'increase quality by 1' do
            expect(item.quality).to eq(initial_quality+1)
          end

          context "with max quality" do
            let(:initial_quality) { 50 }
            it 'will not increase quality above maximum' do
              expect(item.quality).to eq(initial_quality)
            end
          end
        end

        context "on sell date" do
          let(:initial_sell_in) { 0 }
          it 'increases quality by 2' do
            expect(item.quality).to eq(initial_quality + 2)
          end

          context "near max quality" do
            let(:initial_quality) { 49 }
            it 'will not increase quality above maximum' do
              expect(item.quality).to eq(50)
            end
          end

          context "with max quality" do
            let(:initial_quality) { 50 }
            it 'will not increase quality above maximum' do
              expect(item.quality).to eq(initial_quality)
            end
          end
        end

        context "after sell date" do
          let(:initial_sell_in) { -10 }

          it 'increases quality by 2' do
            expect(item.quality).to eq(initial_quality + 2)
          end

          context "at max quality" do
            let(:initial_quality) { 50 }
            it 'will not increase quality above maximum' do
              expect(item.quality).to eq(50)
            end
          end
        end
      end

      context "Sulfuras" do
        let(:initial_quality) { 80 }
        let(:name) { "Sulfuras, Hand of Ragnaros" }

        it 'does not change sell in' do
          expect(item.sell_in).to eq(initial_sell_in)
        end

        context "before sell date" do
          it 'does not change quality' do
            expect(item.quality).to eq(initial_quality)
          end
        end

        context "on sell date" do
          let(:initial_sell_in) { 0 }
          it 'does not change quality' do
            expect(item.quality).to eq(initial_quality)
          end
        end

        context "after sell date" do
          let(:initial_sell_in) { -10 }
          it 'does not change quality' do
            expect(item.quality).to eq(initial_quality)
          end
        end
      end

      context "Backstage pass" do
        let(:name) { "Backstage passes to a TAFKAL80ETC concert" }

        it 'reduces sell in by 1' do
          expect(item.sell_in).to eq(initial_sell_in-1)
        end

        context "long before sell date" do
          let(:initial_sell_in) { 11 }
          it 'increases quality by 1' do
            expect(item.quality).to eq(initial_quality+1)
          end

          context "at max quality" do
            let(:initial_quality) { 50 }

            it 'will not increase quality above maximum' do
              expect(item.quality).to eq(50)
            end
          end
        end

        context "medium close to sell date (upper bound)" do
          let(:initial_sell_in) { 10 }
          it 'increases quality by 2' do
            expect(item.quality).to eq(initial_quality+2)
          end

          context "at max quality" do
            let(:initial_quality) { 50 }
            it 'will not increase quality above maximum' do
              expect(item.quality).to eq(50)
            end
          end
        end

        context "medium close to sell date (lower bound)" do
          let(:initial_sell_in) { 6 }
          it 'increases quality by 2' do
            expect(item.quality).to eq(initial_quality+2)
          end

          context "at max quality" do
            let(:initial_quality) { 50 }
            it 'will not increase quality above maximum' do
              expect(item.quality).to eq(50)
            end
          end
        end

        context "very close to sell date (upper bound)" do
          let(:initial_sell_in) { 5 }
          it 'increases quality by 3' do
            expect(item.quality).to eq(initial_quality+3)
          end

          context "at max quality" do
            let(:initial_quality) { 50 }
            it 'will not increase quality above maximum' do
              expect(item.quality).to eq(50)
            end
          end
        end

        context "very close to sell date (lower bound)" do
          let(:initial_sell_in) { 1 }
          it 'increases quality by 3' do
            expect(item.quality).to eq(initial_quality+3)
          end

          context "at max quality" do
            let(:initial_quality) { 50 }
            it 'will not increase quality above maximum' do
              expect(item.quality).to eq(50)
            end
          end
        end

        context "on sell date" do
          let(:initial_sell_in) { 0 }
          it 'quality drops to 0' do
            expect(item.quality).to eq(0)
          end
        end

        context "after sell date" do
          let(:initial_sell_in) { -10 }
          it 'quality drops to 0' do
            expect(item.quality).to eq(0)
          end
        end
      end

      context "conjured item" do
        before { skip 'to be implemented' }
        let(:name) { "Conjured Mana Cake" }

        it 'reduces sell in by 1' do
          expect(item.sell_in).to eq(initial_sell_in-1)
        end

        context "before the sell date" do
          let(:initial_sell_in) { 5 }
          it 'increases quality by 2' do
            expect(item.quality).to eq(initial_quality+2)
          end

          context "at zero quality" do
            let(:initial_quality) { 0 }
            it 'does not increase quality' do
              expect(item.quality).to eq(0)
            end
          end
        end

        context "on sell date" do
          let(:initial_sell_in) { 0 }
          it 'reduces quality by 4' do
            expect(item.quality).to eq(initial_quality-4)
          end

          context "at zero quality" do
            let(:initial_quality) { 0 }
            it 'does not increase quality' do
              expect(item.quality).to eq(0)
            end
          end
        end

        context "after sell date" do
          let(:initial_sell_in) { -10 }
          it 'reduces quality by 4' do
            expect(item.quality).to eq(initial_quality-4)
          end

          context "at zero quality" do
            let(:initial_quality) { 0 }
            it 'does not increase quality' do
              expect(item.quality).to eq(0)
            end
          end
        end
      end
    end

    context "with several objects" do
      let(:items) {
        [
          Item.new("NORMAL ITEM", 5, 10),
          Item.new("Aged Brie", 3, 10),
        ]
      }

      subject { described_class.new(items) }
      before do
        subject.update_quality
      end

      it 'updates first item' do
        item = items[0]
        expect(item.quality).to eq(9)
        expect(item.sell_in).to eq(4)
      end

      it 'updates second item' do
        item = items[1]
        expect(item.quality).to eq(11)
        expect(item.sell_in).to eq(2)
      end
    end
  end
end
