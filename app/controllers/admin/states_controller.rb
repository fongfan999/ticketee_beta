class Admin::StatesController < Admin::ApplicationController
	def index
		@states = State.all
	end

	def new
		@state = State.new
	end

	def create
		@state = State.new(params.require(:state).permit(:name, :color))

		if @state.save
			flash[:notice] = "State has been created."
			redirect_to admin_states_path
		else
			flash.now[:alert] = "State has not been created."
			render "new"
		end
	end
end
