require 'rails_helper'

RSpec.describe 'ユーザ登録・ログイン・ログアウト機能', type: :system do

  describe 'ユーザ登録のテスト' do
    context 'ユーザのデータがなくログインしていない場合' do
      it 'ユーザ新規登録のテスト' do
        visit new_user_path
        fill_in 'ユーザ名', with: 'sample'
        fill_in 'メールアドレス', with: 'sample@example.com'
        fill_in 'パスワード', with: '000000'
        fill_in 'パスワード(確認用)', with: '000000'
        click_on '登録する'
        expect(current_path).to eq root_path
      end
      it 'ログインしていない時はログイン画面に飛ぶテスト' do
        visit root_path
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe 'セッション機能のテスト' do
    before do
      FactoryBot.create(:user)
    end
    context 'ユーザのデータがありログインしてない場合' do
      it 'ログインできる' do
        visit new_session_path
        fill_in 'メールアドレス', with: 'sample@example.com'
        fill_in 'パスワード', with: '000000'
        click_on 'ログイン'
        expect(current_path).to eq root_path
      end
      it 'ログイン後、自分の詳細ページに飛べる' do
        visit new_session_path
        fill_in 'メールアドレス', with: 'sample@example.com'
        fill_in 'パスワード', with: '000000'
        click_on 'ログイン'
        sleep 0.5
        click_on 'Profile'
        expect(current_path).to eq user_path(id: 1)
      end
      it 'ログイン後、ログアウトできる' do
        visit new_session_path
        fill_in 'メールアドレス', with: 'sample@example.com'
        fill_in 'パスワード', with: '000000'
        click_on 'ログイン'
        sleep 0.5
        click_on 'Logout'
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe '管理画面のテスト' do
    before do
      FactoryBot.create(:user)
      FactoryBot.create(:admin_user)
    end
    context '管理者が存在する場合' do
      it '管理者は管理画面にアクセスできる' do
        visit new_session_path
        fill_in 'メールアドレス', with: 'admin@example.com'
        fill_in 'パスワード', with: '000000'
        click_on 'ログイン'
        sleep 0.5
        click_on '管理画面'
        expect(current_path).to eq admin_users_path
      end
      it '一般ユーザは管理画面にアクセスできない' do
        visit new_session_path
        fill_in 'メールアドレス', with: 'sample@example.com'
        fill_in 'パスワード', with: '000000'
        click_on 'ログイン'
        sleep 0.5
        visit admin_users_path
        expect(current_path).to eq root_path
      end
    end
    context '管理者が操作した場合' do
      before do
        visit new_session_path
        fill_in 'メールアドレス', with: 'admin@example.com'
        fill_in 'パスワード', with: '000000'
        click_on 'ログイン'
      end
      it '管理者はユーザを新規登録できる' do
        visit admin_users_path
        click_on 'ユーザ作成'
        sleep 0.5
        fill_in 'ユーザ名', with: 'newuser'
        fill_in 'メールアドレス', with: 'newuser@example.com'
        fill_in 'パスワード', with: '000000'
        fill_in 'パスワード(確認用)', with: '000000'
        click_on '登録する'
        sleep 0.5
        users = all('tbody tr')
        expect(users[2]).to have_content 'newuser'
      end
      it '管理者はユーザの詳細画面にアクセスできる' do
        visit admin_users_path
        first('tbody tr').click_on '詳細'
        expect(current_path).to eq admin_user_path(id: 1)
      end
      it '管理者はユーザを編集できる' do
        visit admin_users_path
        first('tbody tr').click_on '編集'
        fill_in 'ユーザ名', with: 'sample_change'
        click_on '更新する'
        sleep 0.5
        users = all('tbody tr')
        expect(users[0]).to have_content 'sample_change'
      end
      it '管理者はユーザを削除できる' do
        visit admin_users_path
        first('tbody tr').click_on '削除'
        page.driver.browser.switch_to.alert.accept
        sleep 0.5
        users = all('tbody tr')
        expect(users[0]).to have_content 'admin'
      end
    end
  end
end
