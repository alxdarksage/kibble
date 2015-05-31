class Store < ActiveRecord::Base
    attr_accessible :name, :policy, :owner_profession, :owner_trait
    attr_accessible :bag_query, :bag_total_value, :bag_min_value 
    attr_accessible :bag_max_value, :tag_ids, :id, :created_at, :updated_at
    has_and_belongs_to_many :tags
    
    validates :name, :owner_profession, :presence => true
    validates :bag_total_value, :numericality => { :greater_than_or_equal_to => 10, :allow_blank => true }
    validates :bag_min_value, :numericality => { :greater_than_or_equal_to => 1, :allow_blank => true }
    validates :bag_max_value, :numericality => { :greater_than_or_equal_to => 1, :allow_blank => true }
    
    def pruned_tags
        frequency = (Tag.where(:cat => 'frequency').pluck(:name) & tags.pluck(:name))
        removals = Tag.where(:cat => ['kit']).pluck(:name)
        frequency + ((tags.pluck(:name).sort) - removals)
    end
    
end