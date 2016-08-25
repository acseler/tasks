require 'rails_helper'

RSpec.describe Comment, type: :model do

  let(:comment) { FactoryGirl.build(:comment) }

  it{ should have_db_column(:message) }
  it{ should validate_presence_of(:message) }
  it{ should belong_to(:task) }
  it 'has valid factory' do
    expect(comment).to be_valid
  end
end
