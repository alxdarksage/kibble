class Tag < ActiveRecord::Base
    attr_accessible :name, :category, :description, :suppress_on_export, :rel

    has_and_belongs_to_many :items
    has_and_belongs_to_many :professions
    has_and_belongs_to_many :stores
    has_and_belongs_to_many :seeds, :class_name => Profession, :join_table => 'professions_seeds'
    has_and_belongs_to_many :traits, :class_name => Profession, :join_table => 'professions_traits'

    scope :item_tags, where("rel like ?", "%|item|%").order(:category, :name)
    scope :store_tags, where("rel like ?", "%|store|%").order(:category, :name)
    scope :profession_tags, where("rel like ?", "%|profession|%").order(:category, :name)
    scope :trait_tags, where("rel like ?", "%|trait|%").order(:category, :name)
    scope :encounter_tags, where("rel like ?", "%|encounter|%").order(:category, :name)
    
    def uses_count
        (items + professions + stores).size
    end
    
    validates :name, :category, :presence => true
    validates :name, :uniqueness => true
end
