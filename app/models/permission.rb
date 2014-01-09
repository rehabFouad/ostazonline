class Permission < ActiveRecord::Base
  belongs_to :user
  attr_accessible :action, :description, :name, :subject_class, :subject_id, :user_id
  def self.for_user(user)
    Permission.find_all_by_user_id(user.id).try(:map) { |permission| "#{permission.action},#{permission.subject_class}\n |"}.join
  end
end
