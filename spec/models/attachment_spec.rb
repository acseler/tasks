require 'rails_helper'

RSpec.describe Attachment, type: :model do

  let(:attach) { FactoryGirl.build(:attachment) }

  it{ should have_db_column(:file) }
  it{ should validate_presence_of(:file) }
  it{ should belong_to(:comment) }
  it 'has valid factory' do
    expect(attach).to be_valid
  end
end
