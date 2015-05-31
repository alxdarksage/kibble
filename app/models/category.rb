class Category < ActiveRecord::Base
    attr_accessible :name, :prefix, :available_for, :required, :exclusive, :calculated_enc
    
    has_many :tags
end