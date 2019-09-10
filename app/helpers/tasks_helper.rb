module TasksHelper
	def pgnt
		@tasks ||= Task.page(params[:page]).per(PER)
	end
end
