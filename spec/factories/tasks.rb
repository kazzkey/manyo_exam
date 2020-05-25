FactoryBot.define do
  factory :task do
    name { 'default_name1' }
    content { 'default_content1' }
  end
  factory :second_task, class: Task do
    name { 'default_name2' }
    content { 'default_content2' }
  end
end
