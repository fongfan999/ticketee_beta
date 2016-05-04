class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :author, class_name: "User"
  belongs_to :state
  has_many :attachments, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags, uniq: true
  attr_accessor :tag_names

  accepts_nested_attributes_for :attachments, reject_if: :all_blank

  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 10 }

  before_create :assign_default_state

  searcher do
    label :tag, from: :tags, field: "name"
    label :state, from: :state, field: "name"
  end

  def show_tags_in_edit
    tags.map { |tag| [tag.name] }.flatten.join(" ")
  end

  def tag_names=(names)
    @tag_names = names
    names.split.each do |name|
      unless self.tags.exists?(name: name)
        self.tags << Tag.find_or_initialize_by(name: name)
      end
    end
  end

  private

  def assign_default_state
  	self.state ||= State.default
  end
end
