require 'rails_helper'

RSpec.describe RestaurantWheel, type: :model do
  let(:num_stops) { 10 }

  subject(:wheel) { described_class.new num_stops: num_stops }

  describe '#wheel' do
    context 'when there are no Restaurants' do
      it 'raises' do
        expect { subject.wheel }.to raise_error 'Must have restuarants to create a wheel!'
      end
    end

    context 'when there is a single restaurant' do
      let!(:restaurant) { FactoryGirl.create :restaurant }

      it 'returns an array of length num_stops which is all the single restaurant' do
        subject.wheel.tap do |wheel|
          expect(wheel.count).to eq num_stops
          expect(wheel).to eq Array.new(num_stops, restaurant)
        end
      end
    end

    context 'when there are exactly the same number of spaces and restuarants' do
      let(:num_stops) { 10 }
      let!(:restaurants) { FactoryGirl.create_list :restaurant, num_stops }

      it 'returns a randomized array of all the restuarants' do
        subject.wheel.tap do |wheel|
          expect(wheel.count).to eq num_stops
          expect(wheel).to_not eq restaurants
          expect(wheel.sort_by(&:id)).to eq restaurants.sort_by(&:id)
        end
      end
    end

    context 'when there is 1 stop' do
      let(:num_stops) { 1 }
      let!(:restaurants) { FactoryGirl.create_list :restaurant, 10 }

      let!(:best_restaurant) { FactoryGirl.create :restaurant }
      let!(:best_rating) { FactoryGirl.create :rating, rating: 5, restaurant: best_restaurant }

      it 'returns only the best restaurant' do
        subject.wheel.tap do |wheel|
          expect(wheel.count).to eq 1
          expect(wheel.first).to eq best_restaurant
        end
      end
    end

    context 'when there is list of excluded tags and no included tags were provided' do
      let(:excluded_tag_names) { %i(soup sushi) }

      let!(:excluded_soup_restaurant) { FactoryGirl.create :restaurant, tag_names: %i(soup other-tag) }
      let!(:excluded_sushi_restaurant) { FactoryGirl.create :restaurant, tag_names: %i(sushi japanese puppies) }

      subject(:wheel) { described_class.new num_stops: num_stops, excluded_tags: excluded_tag_names }

      context 'when the excluded tags make the restaurant list empty' do
        it 'raises' do
          expect { subject.wheel }.to raise_error 'Must have restuarants to create a wheel!'
        end
      end

      context 'when there are restaurants which do not have the excluded tags' do
        let!(:best_restaurant) { FactoryGirl.create :restaurant, tag_names: %i(food good-food) }

        it 'returns a list containing the non-excluded restaurant' do
          expect(subject.wheel).to include best_restaurant
        end
      end
    end

    context 'when there is list of included tags and no excluded tags were provided' do
      let(:included_tag_names) { %i(soup sushi) }
      let!(:excluded_restaurant) { FactoryGirl.create :restaurant, tag_names: %i(food good-food) }

      subject(:wheel) { described_class.new num_stops: num_stops, included_tags: included_tag_names }

      context 'when the included tags make the restaurant list empty' do
        it 'raises' do
          expect { subject.wheel }.to raise_error 'Must have restuarants to create a wheel!'
        end
      end

      context 'when there are restaurants which do not have the included tags' do
        let!(:included_soup_restaurant) { FactoryGirl.create :restaurant, tag_names: %i(soup other-tag) }
        let!(:included_sushi_restaurant) { FactoryGirl.create :restaurant, tag_names: %i(sushi japanese puppies) }

        it 'returns a list containing the non-excluded restaurant' do
          expect(subject.wheel).to include included_soup_restaurant, included_sushi_restaurant
        end
      end
    end
  end
end
