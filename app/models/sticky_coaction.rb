class StickyCoaction < ActiveRecord::Base
    belongs_to :sticky 
    belongs_to :coaction
    attr_accessible :sticky_id, :coaction_id
end
