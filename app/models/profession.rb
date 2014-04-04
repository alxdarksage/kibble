class Profession < ActiveRecord::Base
    attr_accessible :name, :seed_ids, :trait_ids, :tag_ids, :function
    
    has_and_belongs_to_many :seeds, :class_name => Tag, :join_table => 'professions_seeds'
    has_and_belongs_to_many :traits, :class_name => Tag, :join_table => 'professions_traits'
    has_and_belongs_to_many :tags
    
    validates :name, :presence => true

    def pruned_tags
        frequency = (Tag.where(:category => 'frequency').pluck(:name) & tags.pluck(:name))
        removals = Tag.where(:category => ['source', 'size', 'frequency']).pluck(:name)
        frequency + ((tags.pluck(:name).sort) - removals)
    end

end
