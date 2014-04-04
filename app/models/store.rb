class Store < ActiveRecord::Base
    attr_accessible :name, :policy, :owner_profession, :owner_trait
    attr_accessible :bag_query, :bag_total_value, :tag_ids
    has_and_belongs_to_many :tags
    
    validates :name, :owner_profession, :bag_query, :presence => true
    validates :bag_total_value, :numericality => { :greater_than_or_equal_to => 20, :allow_blank => true }
    
    def pruned_tags
        frequency = (Tag.where(:category => 'frequency').pluck(:name) & tags.pluck(:name))
        removals = Tag.where(:category => ['kit']).pluck(:name)
        frequency + ((tags.pluck(:name).sort) - removals)
    end
    
end