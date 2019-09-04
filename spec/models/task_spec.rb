require 'rails_helper'

RSpec.describe Task, type: :model do
	it "titleが空ならバリデーションが通らない" do
		taks = Task.new(title: '', content: '失敗テスト')
		expect(task).not_to be_valid
	end

	it "contentが空ならバリデーションが通らない" do
	end

	it "titleとcontentに内容が記載されていればバリデーション"
	end
end