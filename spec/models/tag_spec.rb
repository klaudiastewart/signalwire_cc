require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'relationships' do
    it { should belong_to :ticket }
  end

  describe 'class methods' do
    before(:each) do
      @tag_1 = Tag.new(tag_name: 'tag1', count: 4171).tag_name
      @tag_2 = Tag.new(tag_name: 'tAG1', count: 5).tag_name
      @tag_3 = Tag.new(tag_name: 'tag2', count: 10).tag_name
      @tag_4 = Tag.new(tag_name: 'tag3', count: 15).tag_name
      @tag_5 = Tag.new(tag_name: 'TAG3', count: 20).tag_name
      @ticket = Ticket.create(title: 'Cool title', user_id: 1234)
    end

    describe '.unique_tags(tags)' do
      it 'sorts the unique tag names' do
        expect(Tag.unique_tags([@tag_1, @tag_2, @tag_3, @tag_4, @tag_5])).to eq([@tag_1, @tag_3, @tag_4])
      end
    end

    describe '.get_count(ticket, unique_tags)' do
      it 'picks the highest count tag' do
        expect(Tag.get_count(@ticket, [@tag_1, @tag_3, @tag_4])).to eq(Tag.find_by(tag_name: @tag_1))
      end
    end
  end
end
