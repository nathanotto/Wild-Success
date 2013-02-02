class Clump < ActiveRecord::Base
  belongs_to :user
  belongs_to :mission
  attr_accessible :kind, :name
end
