class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :issue
  attr_accessible :description
end
