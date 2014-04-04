namespace :alx do
    
    task :setup => :environment do
        Rails.logger = Logger.new(STDOUT)
    end
    
    desc 'Find clothing sets'
    task :clothing => :setup do
        kit_tags = Tag.where('name like ? and name != ?', 'kit:%', 'kit:personal')
        
        feet = Tag.find_by_name("feet")
        body = Tag.find_by_name("body") # to be clothing, eventually
        head = Tag.find_by_name("head")
        coat = Tag.find_by_name("coat")
        accessories = Tag.find_by_name("accessories")
        male = Tag.find_by_name("male")
        female  = Tag.find_by_name("female")
        
        # Create a report
        report = {}
        kit_tags.each do |kit_tag|
            array = report[kit_tag.name] = []
                
            [feet, body, head, coat, accessories].each do |tag|
                [male, female].each do |gender|
                    count = 0
                    kit_tag.items.each do |item|
                        # What is relevant here though is if something has many names, that's like
                        # having more than one item. 
                        if item.tags.include?(tag) && item.tags.include?(gender)
                            count += item.name.split(';').size
                        end
                    end.length
                    if (count == 0)
                        array << "lacks tag '#{tag.name}' for #{gender.name}" 
#                    elsif (count < 3)
#                        array << "has less than 3 kinds of tag '#{tag.name}' for #{gender.name}"
                    end
                end
            end
        end
        print_out report
    end

    desc 'Find incomplete kit sets'
    task :kit => :setup do 
        kit_tags = Tag.where('name like ?', 'kit:%')
        
        # Specific tags we're looking for
        firearm = Tag.find_by_name("firearm")
        melee = Tag.find_by_name("melee")
        
        # Create a report
        report = {}
        kit_tags.each do |kit_tag|
            array = report[kit_tag.name] = []
                
            [firearm, melee].each do |tag|
                count = 0
                kit_tag.items.each do |item|
                    # What is relevant here though is if something has many names, that's like
                    # having more than one item. 
                    if item.tags.include?(tag)
                        count += item.name.split(';').size
                    end
                end.length
                if (count == 0)
                    array << "lacks tag '#{tag.name}'" 
#                    elsif (count < 3)
#                        array << "has less than 3 kinds of tag '#{tag.name}' for #{gender.name}"
                end
            end
        end
        print_out report
    end
    
    private
    
    def print_out(report)
        report.each do |arr|
            unless (arr[1].empty?)
                Rails.logger.debug("#{arr[0]}:")
                arr[1].each do |line|
                    Rails.logger.debug("    #{line}")
                end
            end
        end
    end
    
end
