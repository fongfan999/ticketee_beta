module TicketsHelper
	def state_transition_for(comment)
		if comment.previous_state != comment.state
			content_tag(:p) do
				value = "<strong><i class='fa fa-gears'> state changed</i></strong>"
				if comment.previous_state.present?
					value += " from #{render comment.previous_state}"
				end
				value += " to #{render comment.state}"
				value.html_safe
			end
		end
	end
end
