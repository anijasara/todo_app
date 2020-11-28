require 'rails_helper'

RSpec.describe TemplateList, type: :model do
  describe '#associations' do
    it { should belong_to(:list) }
    it { should belong_to(:template) }
  end
end
