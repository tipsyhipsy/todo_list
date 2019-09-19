class TasksController < ApplicationController
	before_action :set_task, only: %i[show edit update destroy]
	before_action :require_log_in!, only: %i[index new edit update destroy]
	PER = 5

	def index
		@q = search_tasks.ransack(params[:q])
		if params[:q]
			@tasks = @q.result.page(params[:page]).per(PER)
		elsif params[:sort_expired]
			@tasks = search_tasks.expired.page(params[:page]).per(PER)
		elsif params[:sort_priority]
			@tasks = search_tasks.priority.page(params[:page]).per(PER)
		else
			@tasks = search_tasks.default.page(params[:page]).per(PER)
		end
	end

	def show
	end

	def new
		@task = Task.new
	end

	def create
		@task = current_user.tasks.build(task_params)
		@label = Task.labels.build(task_params)
		if @task.save
			redirect_to root_path, notice: "作成しました。"
		else
			render :new, danger: "作成に失敗しました。"
		end
	end

	def edit
	end

	def update
		if @task.update(task_params)
			redirect_to root_path, notice: "更新しました。"
		else
			render :edit, alert: "更新に失敗しました。"
		end
	end

	def destroy
		@task.destroy
		redirect_to root_path, notice: "削除しました。"
	end

	private

	def task_params
		params.require(:task).permit(:name, :description, :expired_at, :state, :priority, { label_ids: []})
	end

	def set_task
		@task = Task.find(params[:id])
	end

	def search_tasks
		@search = Task.where(user_id: current_user.id)
	end
end
