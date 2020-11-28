require 'rails_helper'

RSpec.describe Template, type: :model do
  describe '#associations' do
    it { should have_many(:tasks) }
    it { should have_many(:lists) }
  end

  describe '#validations' do
    it "should validates uniqueness of template_id" do
      should validate_uniqueness_of(:template_id)
    end

    it "should validates presence of name" do
      should validate_presence_of(:name)
    end

    it "should validates presence of template_id" do
      should validate_presence_of(:template_id)
    end
  end
end
