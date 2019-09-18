require 'rails_helper'

RSpec.feature "ユーザー機能", type: :feature do
	include SessionsHelper
	let!(:user_first) { FactoryBot.create(:user_first)}
	let!(:user_second) { FactoryBot.create(:user_second)}

	scenario "登録のテスト" do
		visit new_user_path

		fill_in '名前', with:'test1'
		fill_in 'メールアドレス', with:'test1@test.com'
		fill_in 'パスワード', with:'test1'
		fill_in 'パスワード確認', with:'test1'
		click_on '登録する'

		expect(page).to have_content 'test1'
  end

	scenario "ログインのテスト" do
		visit login_path

		fill_in 'メールアドレス', with:'foo@foo.com'
		fill_in 'パスワード', with:'password'
		click_on 'ログイン'

		expect(page).to have_content 'foo'
	end

	describe "ログイン中のテスト" do
		before do
			visit login_path

			fill_in 'メールアドレス', with:'foo@foo.com'
			fill_in 'パスワード', with:'password'
			click_on 'ログイン'
		end

		scenario "ログアウトのテスト" do
			click_on 'ログアウト'

			expect(page).to have_content 'ログアウトしました。'
		end

		scenario "ログインしているユーザーが登録ページにアクセスした時、taskページに遷移できているかのテスト" do
			visit new_user_path

			expect(page).to have_content 'foo'
		end

		scenario "ログインユーザー以外の、他のユーザーのshowページに遷移できない" do
			visit user_path(11)
			expect(page).to have_content '権限がありません。'
		end
	end
end