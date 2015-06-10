class TagTopic < ActiveRecord::Base
  validates :tag_name, uniqueness: true

  has_many :
  # belongs_to :submitter,
  #   class_name: "User",
  #   foreign_key: :submitter_id,
  #   primary_key: :id
end
