require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
  end
  describe 'タスク一覧画面' do
    context '複数のタスクを作成した場合' do
      it '作成済みのタスクが表示される' do
        visit root_path
        expect(page).to have_content 'default_name1'
        expect(page).to have_content 'default_name2'
      end
    end
    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいる' do
        visit root_path
        task_list = all('tbody tr')
        expect(task_list[0]).to have_content 'default_name2'
        expect(task_list[1]).to have_content 'default_name1'
      end
    end
  end
  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        visit new_task_path
        fill_in 'Name', with: 'task_name'
        fill_in 'Content', with: 'task_content'
        click_on '登録する'
        expect(page).to have_content 'task_name'
        expect(page).to have_content 'task_content'
      end
    end
  end
  describe 'タスク詳細画面' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示されたページに遷移する' do
         new_task = FactoryBot.create(:task, name: 'new_name', content: 'new_content')
         visit root_path
         first('tbody tr').click_on '詳細'
         expect(page).to have_content 'new_name'
         expect(page).to have_content 'new_content'
       end
     end
  end
end
