FactoryBot.define do
  factory :task do
    task_id { "MyString" }
    name { "MyText" }
    description { "MyText" }
    status { "MyString" }
    done_at { "2020-11-27 12:46:26" }
    due_at { "2020-11-27 12:46:26" }
    list { nil }
  end
end
