require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
	background do
		FactoryBot.create(:task)
		FactoryBot.create(:second_task)
		FactoryBot.create(:third_task)
		# FactoryBot.create(:fourth_task)
		# FactoryBot.create(:fifth_task)
	end

	scenario "タスク一覧のテスト" do
		visit tasks_path
		expect(page).to have_content 'name01'
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
		visit task_path(8)
		expect(page).to have_content 'name01'
		expect(page).to have_content 'description01'
	end

	scenario "タスクが作成日時の降順に並んでいるかのテスト" do
		visit tasks_path
    expect(Task.order("created_at DESC").map(&:id)).to eq [13, 12, 11]
	end

	scenario "タスクが終了期限で昇順に並び替えできているかテスト" do
		visit tasks_path
		click_on '終了期限で並び替え'
    expect(Task.order("expired_at ASC").map(&:id)).to eq [14, 15, 16]
    
	scenario "タスクの曖昧検索ができているかのテスト" do
		visit tasks_path
		fill_in "タスク名検索", with: "1"
		click_on "Search"
		expect(page).to have_content 'name01'
	end

	scenario "タスクのand検索ができているかのテスト" do
		FactoryBot.create(:fourth_task)

		visit tasks_path
		fill_in "タスク名検索", with: "name"
		choose 'q_state_eq_1'
		click_on 'Search'
		expect(page).to have_content 'name04'
	end
end