class TasksController < ApplicationController
	before_action :set_task, only: %i[show edit update destroy]
	before_action :require_log_in!, only: %i[index new edit update destroy]
	PER = 5

	def index
		@q = Task.ransack(params[:q])
		if params[:q]
			@tasks = @q.result.page(params[:page]).per(PER)
		elsif params[:sort_expired]
			@tasks = Task.expired.page(params[:page]).per(PER)
		elsif params[:sort_priority]
			@tasks = Task.priority.page(params[:page]).per(PER)
		else
			@tasks = Task.default.page(params[:page]).per(PER)
		end
	end

	def show
	end

	def new
		@task = Task.new
	end

	def create
		@task = current_user.tasks.build(task_params)
		if @task.save
			redirect_to tasks_path, notice: "作成しました。"
		else
			render :new, danger: "作成に失敗しました。"
		end
	end

	def edit
	end

	def update
		if @task.update(task_params)
			redirect_to tasks_path, notice: "更新しました。"
		else
			render :edit, denger: "更新に失敗しました。"
		end
	end

	def destroy
		@task.destroy
		redirect_to tasks_path, notice: "削除しました。"
	end

	private

	def task_params
		params.require(:task).permit(:name, :description, :expired_at, :state, :priority)
	end

	def set_task
		@task = Task.find(params[:id])
	end

	def require_log_in!
		unless logged_in?
			flash[:alert] = "ログインしてください。"
			redirect_to new_session_path
		end
	end

end
