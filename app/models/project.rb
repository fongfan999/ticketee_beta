class Project < ActiveRecord::Base
	has_many :tickets, dependent: :destroy
	has_many :roles, dependent: :destroy

	validates :name, presence: true
end
