FactoryBot.define do
  factory :task do
    name { 'default_name1' }
    content { 'default_content1' }
    expired_at { '2020-01-02' }
  end
  factory :second_task, class: Task do
    name { 'default_name2' }
    content { 'default_content2' }
    expired_at { '2020-01-01' }
  end
end
