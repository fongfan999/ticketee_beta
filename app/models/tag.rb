class Tag < ActiveRecord::Base
	has_and_belongs_to_many :tags, uniq: true
end
