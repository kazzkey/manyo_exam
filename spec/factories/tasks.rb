FactoryBot.define do
  factory :task do
    name { 'default_name1' }
    content { 'default_content1' }
    expired_at { '002020-01-02' }
    status { '着手中' }
    priority { '高' }
    user_id { 1 }
  end
  factory :second_task, class: Task do
    name { 'default_name2' }
    content { 'default_content2' }
    expired_at { '002020-01-01' }
    status { '着手中' }
    priority { '中' }
    user_id { 1 }
  end
end
