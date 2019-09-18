require 'rails_helper'

RSpec.feature "管理者機能", type: :feature do
	let!(:user_first){FactoryBot.create(:user_first)}
	let!(:user){FactoryBot.create(:user_admin)}

	scenario "adminページへの切り替えテスト" do
		visit login_path

		fill_in 'メールアドレス', with:'admin@admin.com'
		fill_in 'パスワード', with:'password'
		click_on 'ログイン'
		click_on 'admin'

		expect(current_path).to eq admin_users_path
	end

	scenario "normalページへの切り替えテスト" do
		visit login_path

		fill_in 'メールアドレス', with:'admin@admin.com'
		fill_in 'パスワード', with:'password'
		click_on 'ログイン'
		click_on 'admin'
		click_on 'normal'

		expect(current_path).to eq tasks_path
	end

	scenario "アカウント追加のテスト" do
		visit new_admin_user_path

		fill_in '名前', with:'test1'
		fill_in 'メールアドレス', with:'test1@test.com'
		fill_in 'パスワード', with:'test1'
		fill_in 'パスワード確認', with:'test1'
		click_on '登録する'

		expect(page).to have_content 'test1'
	end

		scenario "ユーザーの編集ができているかのテスト" do
			visit admin_users_path

			click_on '編集', match: :first
			fill_in '名前', with:'Edited_user'
			fill_in 'メールアドレス', with:'edit@edit.com'
			click_on '登録する'

			expect(page).to have_content 'Edited_user'
		end

		scenario "ユーザーの削除ができているかのテスト" do
			visit admin_users_path

			click_on '削除', match: :first

			expect(page).to_not have_content 'foo'
			expect(page).to have_content '削除しました。'
		end
end