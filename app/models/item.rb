 class Item < ActiveRecord::Base
    include ActiveModel::Validations

    attr_accessible :enc, :name, :value, :tag_ids, :calculated_value, :calculated_enc
    has_and_belongs_to_many :tags
    
    validates :name, :value, :enc, :presence => true
    validates :name, :uniqueness => true
    validates_with TagValidator
    
    before_save :calc_fields
     
    def pruned_tags
        frequency = (Tag.where(:category => 'frequency').pluck(:name) & tags.pluck(:name))
        removals = Tag.where(:category => ['source', 'size', 'frequency']).pluck(:name)
        removals << 'nobr' # implied by br
        frequency + ((tags.pluck(:name).sort) - removals)
    end

    private
     
    def calc_fields
        self.calculated_value = calculate_value()
        self.calculated_enc = calculate_encumbrance()
    end
    
    def calculate_value
        tag_names = tags.map {|t| t.name } 
        # Rails.logger.info("CV tags: #{tag_names.join(', ')}")
        e = 1
        # Types of things that are more valuable
        e += includes_tag(tag_names, ['melee'], 2)
        e += includes_tag(tag_names, ['firearm'], 8)
        e += includes_tag(tag_names, ['food', 'preserved'], 2)
        e += includes_tag(tag_names, ['rifle'], 3)
        
        # Frequency. But ignore stuff that is considered vital to survival, as that is priced separately.
        unless (tag_names.include?('ammo') || tag_names.include?('firearm') || tag_names.include?('food') || tag_names.include?('melee') || tag_names.include?('armor'))
            e += includes_tag(tag_names, ['uncommon'], 2)
            e += includes_tag(tag_names, ['rare'], 5)
        end

        # kind        
        e += includes_tag(tag_names, ['jewelry', 'tiny'], 4)
        e += includes_tag(tag_names, ['jewelry', 'hand'], 9)

        # value
        e += includes_tag(tag_names, ['historical'], 2)
        e += includes_tag(tag_names, ['luxury'], 3)
        e += includes_tag(tag_names, ['drug'], 7)
        e += includes_tag(tag_names, ['useful','tiny'], 2)
        e += includes_tag(tag_names, ['useful','hand'], 5)
        e += includes_tag(tag_names, ['useful','small'], 8)
        e += includes_tag(tag_names, ['useful','medium'], 10)
        e += includes_tag(tag_names, ['useful','large'], 14)
        e += includes_tag(tag_names, ['useful','huge'], 18)
        e += includes_tag(tag_names, ['scifi'], e*2)
        e
    end
     
    #    current thinking about this
    #     size
    #
    #     tiny        pocket (enc .5)
    #     hand        hand (enc 1)
    #     small       can be carried in one hand, would fit under an arm (enc 3)
    #     medium      under an arm (enc 10)
    #     large       two-hands or back with means to carry (enc 20)
    #     huge        carried only by two people or a giant (enc 40)
    #
    #     cc = 70 + (10*Strong) (?)
    #
    #     weight
    #     normal      FOR SIZE                                    0
    #     heavy       FOR SIZE                                    size enc * 2
    #
    #     value
    def calculate_encumbrance
        tag_names = tags.map {|t| t.name }
        # Rails.logger.info("CE tags: #{tag_names.join(', ')}")
        e = 0
        e += includes_tag(tag_names, ['tiny'], 0.5)
        e += includes_tag(tag_names, ['hand'], 1)
        e += includes_tag(tag_names, ['small'], 3)
        e += includes_tag(tag_names, ['medium'], 10) # 8
        e += includes_tag(tag_names, ['large'], 20)
        e += includes_tag(tag_names, ['huge'], 40)
        e += includes_tag(tag_names, ['heavy'], e) 
        e
    end
     
    def includes_tag(tag_names, array, value)
        ((tag_names - array).size == (tag_names.size - array.size)) ? value : 0
    end
end
