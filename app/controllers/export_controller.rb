class ExportController < ApplicationController

    # More compact: base 36:
    # 1412823931503067241.to_s(36)  #=> "aqf8aa0006eh"
    # "aqf8aa0006eh".to_i(36)  #=> 1412823931503067241
    
    # JavaScript implementation[edit]
    # (1234567890).toString(36)  // => "kf12oi"
    # parseInt("kf12oi",36) // => 1234567890
    
    def index
        post = Tag.find_by_name('post')
        
        @items = Item.order(:name).all
        @professions = Profession.order(:name).all
        @stores = Store.order(:name).all
        
        @item_tags = Tag.item_tags.select { |tag| tag.items.count > 0 }.collect(&:name)
        @item_tag_indexes = array_to_index_hash(@item_tags)

        @prof_tags = (Tag.profession_tags + Tag.trait_tags).collect(&:name)
        @prof_tag_indexes = array_to_index_hash(@prof_tags)
        
        @store_tags = Tag.store_tags.select { |tag| tag.stores.count > 0 }.collect(&:name)
        @store_tag_indexes = array_to_index_hash(@store_tags)
        
        render :content_type => 'text', :layout => false
    end
    
    private 
    
    def array_to_index_hash(array)
        hash = {}
        array.each_with_index do |element, index|
            hash[element] = index
        end
        hash
    end

end
