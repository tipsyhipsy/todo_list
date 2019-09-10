# 「FactoryBotを使用します」という記述
FactoryBot.define do

  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  factory :task do
    name { 'name01' }
		description { 'description01' }
    created_at {'2019-09-01'}
    priority { 2 }
  end

  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :second_task, class: Task do
    name { 'name02' }
		description { 'description02' }
    created_at {'2019-09-02'}
    priority { 1 }
	end

  factory :third_task, class: Task do
    name { 'name03' }
		description { 'description03' }
    created_at {'2019-09-03'}
    priority { 0 }
  end

  # stateを検索するためのテスト用データ
  factory :fourth_task, class: Task do
    name { 'name04' }
		description { 'description04' }
		created_at {'2019-09-04'}
    state { 1 }
  end

end