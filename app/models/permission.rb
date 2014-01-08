class Permission < ActiveRecord::Base
  belongs_to :user
  attr_accessible :action, :description, :name, :subject_class, :subject_id, :user_id
end
