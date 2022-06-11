RSpec.describe Ticket, type: :model do
  describe 'relationships' do
    it { should have_many(:tags) }
  end

  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :user_id }
  end
end
