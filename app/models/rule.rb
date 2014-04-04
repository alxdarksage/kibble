class Rule < ActiveRecord::Base
    attr_accessible :identifier, :parameters
    
    validates :identifier, :parameters, :presence => true
end
