class Permission < ActiveRecord::Base
  attr_accessible :action, :description, :name, :subject_class, :subject_id, :user_id
end
