require "rails_helper"

RSpec.feature "Users can delete unwanted tags from a ticket" do
	let(:user) { FactoryGirl.create(:user) }
	let(:project) { FactoryGirl.create(:project) }
	let(:ticket) do
		FactoryGirl.create(:ticket, project: project, author: user,
			tag_names: "ThisTagMustDie")
	end

	before do
		login_as(user)
		assign_role!(user, :manager, project)
		visit project_ticket_path(project, ticket)
	end

	scenario "successfully", js: true do
		within tag("ThisTagMustDie") do
			click_link "remove"
		end

		expect(page).not_to have_content "ThisTagMustDie"
	end
end