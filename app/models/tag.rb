class Tag < ActiveRecord::Base
    attr_accessible :name, :cat, :description, :suppress_on_export, :rel

    belongs_to :category
    has_and_belongs_to_many :items
    has_and_belongs_to_many :professions
    has_and_belongs_to_many :stores
    has_and_belongs_to_many :seeds, :class_name => Profession, :join_table => 'professions_seeds'
    has_and_belongs_to_many :traits, :class_name => Profession, :join_table => 'professions_traits'

    scope :item_tags, where("rel like ?", "%|item|%").order(:cat, :name)
    scope :store_tags, where("rel like ?", "%|store|%").order(:cat, :name)
    scope :profession_tags, where("rel like ?", "%|profession|%").order(:cat, :name)
    scope :trait_tags, where("rel like ?", "%|trait|%").order(:cat, :name)
    scope :encounter_tags, where("rel like ?", "%|encounter|%").order(:cat, :name)
    
    def uses_count
        (items + professions + stores).size
    end
    
    validates :name, :cat, :presence => true
    validates :name, :uniqueness => true
end
