require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
	include SessionsHelper
	let!(:label){FactoryBot.create(:label)}
	let!(:label_second){FactoryBot.create(:label_second)}
	let!(:label_third){FactoryBot.create(:label_third)}

	before do
		FactoryBot.create(:task, user: FactoryBot.create(:user))

		visit login_path

		fill_in 'メールアドレス', with:'foo@foo.com'
		fill_in 'パスワード', with:'password'
		click_on 'ログイン'
	end

	scenario "タスク一覧のテスト" do
		visit root_path

		expect(page).to have_content 'foo'
		expect(page).to have_content 'description01'
	end

	scenario "タスク作成のテスト" do
		visit new_task_path

		fill_in '名前', with: "task1"
		fill_in '詳細', with: "hoge"
		fill_in '期限', with: "2019/08/01"
		click_on '登録する'

		expect(page).to have_content 'task1'
		expect(page).to have_content 'hoge'
	end

	scenario "タスク詳細のテスト" do
		visit root_path
		click_link '詳細' #登録済みtaskは1つ

		expect(page).to have_content 'name01'
		expect(page).to have_content 'description01'
	end

	scenario "タスクが作成日時の降順に並んでいるかのテスト" do
		visit new_task_path

		fill_in '名前', with: "task1"
		fill_in '詳細', with: "hoge"
		fill_in '期限', with: "2019/08/01"
		click_on '登録する'

    expect(Task.order("created_at DESC").map(&:id)).to eq [6, 5]
	end

	scenario "タスクが終了期限で昇順に並び替えできているかテスト" do
		visit new_task_path

		fill_in '名前', with: "task1"
		fill_in '詳細', with: "hoge"
		fill_in '期限', with: "2019/08/01"
		click_on '登録する'
		click_on '終了期限で並び替え'

		expect(Task.order("expired_at ASC").map(&:id)).to eq [8, 7]
	end

	scenario "タスクが優先順位で昇順に並び替えできているかテスト" do
		visit new_task_path

		fill_in '名前', with: "task1"
		fill_in '詳細', with: "hoge"
		fill_in '期限', with: "2019/08/01"
		click_on '登録する'
		click_on '優先順位で並び替え'
		expect(Task.order("priority ASC").map(&:id)).to eq [10, 9]
	end

	scenario "タスクの曖昧検索ができているかのテスト" do
		visit new_task_path

		fill_in '名前', with: "task1"
		fill_in '詳細', with: "hoge"
		fill_in '期限', with: "2019/08/01"
		click_on '登録する'
		#root_pathにリダイレクト
		fill_in 'タスク名検索', with: 'task'
		click_on '検索'
		expect(page).to have_content 'task1'
	end

	scenario "タスクのand検索ができているかのテスト" do
		visit new_task_path

		fill_in '名前', with: "name4"
		fill_in '詳細', with: "description04"
		fill_in '期限', with: "2019/09/04"
		click_on '登録する'

		fill_in "タスク名検索", with: "name"
		choose 'q_state_eq_1'
		click_on '検索'

		expect(page).to have_content 'name01'
	end

	scenario "ラベルが登録できるかのテスト" do
		visit new_task_path

		fill_in '名前', with: "task1"
		fill_in '詳細', with: "hoge"
		fill_in '期限', with: "2019/08/01"
		check 'test1'
		click_on '登録する'

		all('tbody tr')[0].click_link '詳細' #タスク一覧テーブルの一番先頭のタスク詳細を選択

		expect(page).to have_content 'test1' #タスク詳細ページにラベルが表示されているか
	end

	scenario "ラベルが変更できるかのテスト" do
		visit tasks_path

		all('tbody tr')[0].click_link '編集' #タスク一覧テーブルの一番先頭のタスク編集を選択

		uncheck 'test1'
		check 'test3'
		click_on '登録する' #task1を外しtest3のみに変更
		all('tbody tr')[0].click_link '詳細'
		expect(page).to have_content 'test3'
	end

	scenario "ラベルで検索できるかのテスト" do
		visit new_task_path

		fill_in '名前', with: "task1"
		fill_in '詳細', with: "hoge"
		fill_in '期限', with: "2019/08/01"
		check 'test2'
		click_on '登録する' #検索対象のlabel id(2)を登録

		check 'test2'
		click_on '検索'

		expect(page).to_not have_content 'name01'#タスクは合計2つ。そのうち、検索対象外が表示されていないか
	end

end