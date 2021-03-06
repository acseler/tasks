require 'rails_helper'

RSpec.describe Task, type: :model do

  let(:task) { FactoryGirl.create(:task) }

  it { should have_db_column(:title) }
  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_most(256) }

  it 'has valid factory' do
    expect(task).to be_valid
  end
end
