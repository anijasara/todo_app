require 'rails_helper'

RSpec.describe List, type: :model do
  let(:list) {
    FactoryBot.create(:list)
  }

  describe '#associations' do
    it { should have_many(:tasks) }
  end

  describe '#validations' do
    it "should validates uniqueness of list_id" do
      should validate_uniqueness_of(:list_id)
    end

    it "should validates presence of name" do
      should validate_presence_of(:name)
    end

    it "should validates presence of task_id" do
      should validate_presence_of(:list_id)
    end
  end

  describe '#class_methods' do
    it "should delete the tasks by passing task_ids" do
      task = FactoryBot.create(:task, name: 'Gardening',list_id: list.id, task_id: 'T01')
      expect(List.delete_tasks([task.id])).to eq(true)
      expect(Task.all).to be_empty
    end
  end
end
