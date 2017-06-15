require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe '.without_tag_names' do
    let(:excluded_tag_names) { %i(soup sushi) }

    let!(:excluded_soup_restaurant) { FactoryGirl.create :restaurant, tag_names: %i(soup other-tag) }
    let!(:excluded_sushi_restaurant) { FactoryGirl.create :restaurant, tag_names: %i(sushi japanese puppies) }

    subject { described_class.without_tag_names excluded_tag_names }

    context 'when all restaurants are filtered out' do
      it 'returns an empty list' do
        expect(subject.empty?).to eq true
      end
    end
  end
end
