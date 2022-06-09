require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe Ticket, type: :model do
  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :user_id }
    it { should allow_value(Array.new(0)).for(:tags) }
    it { should allow_value(Array.new(5, "tag1")).for(:tags) }
    it { should_not allow_value(Array.new(6, "tag1")).for(:tags) }
  end
end
