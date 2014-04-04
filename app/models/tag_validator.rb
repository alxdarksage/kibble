class TagValidator < ActiveModel::Validator
    
    # TODO: Save validation state when saving, not just re-validating
    
    def validate(record)
        Rule.find(:all).each do |rule|
            Rails.logger.debug("Processing rule #{rule.identifier}: #{rule.parameters}")
            tag_set = create_tags(record)
            self.send(rule.identifier, record, tag_set, rule)
        end
    end
    
    def oneOf(record, tag_set, rule)
        set1, set2 = convert_to_two_sets(rule.parameters)
        
        if (one_in_set?(tag_set, set1) && !any_in_set?(tag_set, set2))
            record.errors[:tag] << "'#{set1.to_a.join(', ')}' requires at least one of '#{set2.to_a.join(', ')}'"
        end
    end
    
    def category(record, tag_set, rule)
        category_tag_set = Tag.where(:category => rule.parameters).pluck(:name).to_set
        
        if (!one_in_set?(tag_set, category_tag_set))
            record.errors[:tag] << "requires one '#{rule.parameters}' tag"
        end
    end
    
    def linked(record, tag_set, rule)
        set1, set2 = convert_to_two_sets(rule.parameters)
        
        if (one_in_set?(tag_set, set1) && !one_in_set?(tag_set, set2))
            record.errors[:tag] << "'#{set1.to_a.join(', ')}' requires one of '#{set2.to_a.join(', ')}'"
        end
        if (one_in_set?(tag_set, set2) && !one_in_set?(tag_set, set1))
            record.errors[:tag] << "'#{set2.to_a.join(', ')}' requires one of '#{set1.to_a.join(', ')}'"
        end
    end
    
    def exclusive(record, tag_set, rule)
        set1, set2 = convert_to_two_sets(rule.parameters)
        
        if (one_in_set?(tag_set, set1) && one_in_set?(tag_set, set2))
            record.errors[:tag] << "'#{set1.to_a.join(', ')}' excludes any tags from '#{set2.to_a.join(', ')}'"
        end
    end
    
    def required(record, tag_set, rule)
        set = convert_to_set(rule.parameters)
        
        if !one_in_set?(tag_set, set)
            record.errors[:tag] << "requires one tag from '#{set.to_a.join(', ')}'"
        end
    end
    
    private
    
    def create_tags(record)
        set = record.tags.map { |tag| tag.name }.to_set
        expand_set(set) 
    end
    
    def convert_to_set(string)
        string.split(/\(([^\(\)]*)\)/)[1].split(' ').to_set
    end
    
    def convert_to_two_sets(string)
        set1, set2 = string.split(/\(([^\(\)]*)\)/).select {|s| s.present? }.map { |string| string.split(' ').to_set }
        set1 = expand_set(set1)
        set2 = expand_set(set2)
        [set1, set2]    
    end
    
    def expand_set(set)
        new_set = Set.new
        set.each do |tag_name|
            if tag_name.include?(':*')
                new_set = new_set.merge(Tag.where(['name like ?', "#{tag_name[0,tag_name.length-1]}%"]).all.map{|tag| tag.name})
            else
                new_set.add(tag_name)
            end
        end
        new_set
    end
    
    def any_in_set?(set1, set2)
        (set1 & set2).size > 0
    end
    
    def one_in_set?(set1, set2)
        (set1 & set2).size == 1
    end
    
end
