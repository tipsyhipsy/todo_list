require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
	scenario "タスク一覧のテスト" do
		Task.create!(name: 'test_task_01', description: 'testtesttest')
		Task.create!(name: 'test_task_02', description: 'samplesample')
		visit tasks_path
		expect(page).to have_content 'testtesttest'
		expect(page).to have_content 'samplesample'
  end

  scenario "タスク作成のテスト" do
		visit new_task_path
		fill_in 'Name', with: "task1"
		fill_in 'Description', with: "hoge"
		click_on 'Create Task'

		expect(page).to have_content 'task1'
		expect(page).to have_content 'hoge'
  end

	scenario "タスク詳細のテスト" do
		Task.create!(name: 'test_task_03', description: 'testtesttest',id: '5')
		visit task_path(5)
		expect(page).to have_content 'test_task_03'
		expect(page).to have_content 'testtesttest'
	end

	scenario "タスクが作成日時の降順に並んでいるかのテスト" do
	end
end