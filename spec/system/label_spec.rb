require 'rails_helper'

RSpec.describe 'ラベル機能', type: :system do
  before do
    FactoryBot.create(:user, name: 'sample', email: 'sample@example.com', password: '000000')
    FactoryBot.create(:label)
    FactoryBot.create(:second_label)
    visit new_session_path
    fill_in 'メールアドレス', with: 'sample@example.com'
    fill_in 'パスワード', with: '000000'
    click_on 'ログイン'
  end
  describe 'タスク作成画面' do
    context 'タスク新規作成時に、ラベルを1つまたは複数選択した場合' do
      it 'タスク詳細画面に、選択した1つのラベルが表示される' do
        visit new_task_path
        fill_in 'タスク名', with: 'task_name'
        fill_in 'タスク詳細', with: 'task_content'
        fill_in '終了期限', with: '0020200602'
        select '着手中', from: 'ステータス'
        select '高', from: '優先順位'
        check 'label1'
        click_on '登録する'
        expect(page).to have_content 'label1'
      end
      it 'タスク詳細画面に、選択した2つのラベルが表示される' do
        visit new_task_path
        fill_in 'タスク名', with: 'task_name'
        fill_in 'タスク詳細', with: 'task_content'
        fill_in '終了期限', with: '0020200602'
        select '着手中', from: 'ステータス'
        select '高', from: '優先順位'
        check 'label1'
        check 'label2'
        click_on '登録する'
        expect(page).to have_content 'label1'
        expect(page).to have_content 'label2'
      end
    end
    context 'タスクを編集した場合' do
      it 'ラベルを編集することができる' do
        visit new_task_path
        fill_in 'タスク名', with: 'task_name'
        fill_in 'タスク詳細', with: 'task_content'
        check 'label1'
        click_on '登録する'
        sleep 0.5
        visit root_path
        click_on '編集'
        uncheck 'label1'
        click_on '更新する'
        expect(page).not_to have_content 'label1'
      end
    end
  end
  describe 'タスク一覧画面' do
    context '検索した場合' do
      it 'ラベルで検索できる' do
        visit new_task_path
        fill_in 'タスク名', with: 'task_name'
        fill_in 'タスク詳細', with: 'task_content'
        check 'label1'
        click_on '登録する'
        visit root_path
        select 'label1', from: 'label_id'
        click_on '検索'
        task = all('tbody tr')
        expect(task[0]).to have_content 'task_name'
      end
    end
  end
end
