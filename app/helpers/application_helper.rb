module ApplicationHelper
    
    def is_error?(model, field)
        if (model.errors[field].any?)
            "error"
        else
            ""
        end
    end
        
    def display_value(item)
        if (item.value == 0)
            "<span style='color:#468847'>#{truncate(item.calculated_value)}</span>".html_safe 
        else
            "<b>#{truncate(item.value)}</b>".html_safe
        end
    end
    
    def display_enc(item)
        if (item.enc == 0)
            "<span style='color:#468847'>#{truncate(item.calculated_enc)}</span>".html_safe 
        else
            "<b>#{truncate(item.enc)}</b>".html_safe
        end
    end
    
    def as_item_export_string(item)
        v = (item.value == 0) ? item.calculated_value : item.value
        e = (item.enc == 0) ? item.calculated_enc : item.enc
        
        tags = item.pruned_tags.map do |tag|
            @item_tag_indexes[tag]
        end.join(' ')
        
        "#{item.name}!#{truncate(v)}!#{truncate(e)}!#{tags}".html_safe
    end
    
    def as_store_export_string(store)
        tags = store.pruned_tags.map do |tag|
            @store_tag_indexes[tag]
        end.join(' ')
        
        "#{store.name}!#{store.policy}!#{store.owner_profession}!#{store.owner_trait}!#{store.bag_query}!#{store.bag_total_value}!#{store.bag_min_value}!#{store.bag_max_value}!#{tags}".html_safe
    end

    def as_prof_export_string(prof)
        tags = prof.pruned_tags.map do |tag|
            @prof_tag_indexes[tag]
        end.join(' ')
        seeds = prof.seeds.map do |seed|
            @prof_tag_indexes[seed.name]
        end.join(' ')
        traits = prof.traits.map do |trait|
            @prof_tag_indexes[trait.name]
        end.join(' ')
        
        "#{prof.name}!#{seeds}!#{traits}!#{tags}".html_safe
    end
    
    def truncate(value)
       string = value.to_s
       if string =~ /\.0$/
           string.split('.')[0] 
       elsif string =~ /^0\./
           "."+string.split('.')[1]
       else
           string
       end
    end
end
