require 'rails_helper'

RSpec.describe RestaurantWheel, type: :model do
  let(:num_stops) { 10 }

  subject(:wheel) { described_class.new num_stops }

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

      it 'returns a randomized array of all the restuarants' do
        subject.wheel.tap do |wheel|
          expect(wheel.count).to eq 1
          expect(wheel.first).to eq best_restaurant
        end
      end
    end
  end
end
