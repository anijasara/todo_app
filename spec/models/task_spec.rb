require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:list) {
    FactoryBot.create(:list)
  }

  describe '#associations' do
    it { should belong_to(:list) }
  end

  describe '#validations' do
    it "should validates uniqueness of task_id" do
      FactoryBot.create(:task, name: 'my_task',list_id: list.id, task_id: 'T01')
      should validate_uniqueness_of(:task_id)
    end

    it "should validates presence of name" do
      FactoryBot.create(:task, name: 'my_task',list_id: list.id, task_id: 'T01')
      should validate_presence_of(:name)
    end

    it "should validates presence of task_id" do
      FactoryBot.create(:task, name: 'my_task',list_id: list.id, task_id: 'T01')
      should validate_presence_of(:task_id)
    end
  end

  describe '#class_methods' do
    it "should get the task by passing name as search_param" do
      FactoryBot.create(:task, name: 'Gardening',list_id: list.id, task_id: 'T01')
      task = Task.get_task_by_params('name', 'Gardening')
      expect(task).to be_present
      expect(task.first.name).to eq("Gardening")
    end

    it "should get task as empty if not present" do
      FactoryBot.create(:task, name: 'Gardening',list_id: list.id, task_id: 'T01')
      task = Task.get_task_by_params('created_at', Time.now)
      expect(task).to be_empty
      expect(task).to eq([])
    end
  end
end
