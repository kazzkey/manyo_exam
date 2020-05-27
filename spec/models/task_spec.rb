require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'titleが空ならバリデーションが通らない' do
    task = Task.new(name: '', content: '失敗テスト')
    expect(task).not_to be_valid
  end
  it 'contentが空ならバリデーションが通らない' do
    task = Task.new(name: '失敗テスト', content: '')
    expect(task).not_to be_valid
  end
  it 'titleとcontentに内容が記載されていればバリデーションが通る' do
    task = Task.new(name: '失敗テスト', content: '失敗テスト')
    expect(task).to be_valid
  end
  context 'scopeメソッドで検索をした場合' do
    before do
      Task.create(name: "task", content: "sample_task", status: "着手中")
      Task.create(name: "sample", content: "sample_sample", status: "完了")
    end
    it "scopeメソッドでタイトル検索ができる" do
      expect(Task.name_like('task').count).to eq 1
      expect(Task.name_like('sample').count).to eq 1
    end
    it "scopeメソッドでステータス検索ができる" do
      expect(Task.status('着手中').count).to eq 1
      expect(Task.status('完了').count).to eq 1
    end
    it "scopeメソッドでタイトルとステータスの両方が検索できる" do
      expect(Task.name_like('task').status('着手中').count).to eq 1
      expect(Task.name_like('sample').status('完了').count).to eq 1
    end
  end
end
