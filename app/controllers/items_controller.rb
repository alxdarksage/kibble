class ItemsController < ApplicationController
    
    # Item.includes(:tags).where(:tags => {:name => 'firearm'})
    def index
        # This didn't work using ActiveRecord, so disabled that for the moment. Have no idea
        # how to do this efficiently for multiple search criteria, using AR.
        # ick.
        @items = Item.includes(:tags).order(:name).all
        if (params[:search] || cookies[:search])
            (params[:search] || cookies[:search]).split(/\s/).each do |term|
                value = (term.include?(":")) ? term[(term =~ /:/)+1,term.length] : term
                if (term.start_with?("value:"))
                    @items = @items.select {|item| item.value = 0 && item.calculated_value = value.to_f}
                elsif (term.start_with?("enc:"))
                    @items = @items.select {|item| item.enc = 0 && item.calculated_enc = value.to_f}
                elsif (term.start_with?("-tag:"))
                    @items = @items.select {|item| !item.tags.pluck(:name).include?(value)}
                elsif (term.start_with?("tag:"))
                    @items = @items.select {|item| item.tags.pluck(:name).include?(value)}
                else
                    @items = @items.select {|item| item.name.include?(term)}
                end
            end
        end
        @items = Kaminari.paginate_array(@items).page(params[:page]).per(30)
    end

    def show
        @item = Item.find(params[:id])
        @tags = Tag.item_tags
    end

    def new
        @item = Item.new(:value => 0, :enc => 0)
        @tags = Tag.item_tags
    end
    
    def clone
        @clone = Item.find(params[:id])
        @item = Item.new({:name => @clone.name, :value => @clone.value, :enc => @clone.enc})
        @clone.tags.each do |tag|
            @item.tags << tag
        end
        @tags = Tag.item_tags
        
        render "new"
    end

    def edit
        @item = Item.find(params[:id])
        @tags = Tag.item_tags
    end

    def update_tags
        unless params[:item_ids].nil?
            updaters = Item.find(params[:item_ids])
            if (params[:value])
                Item.update_all({:value => params[:tag].to_d}, {:id => params[:item_ids]})
                notice = "Item value(s) have been updated."
            elsif (params[:enc])
                Item.update_all({:enc => params[:tag].to_d}, {:id => params[:item_ids]})
                notice = "Item enc(s) have been updated."
            else
                tags = params[:tag].split(/\s/)
                tags.each do |tag_name|
                    # tag = Tag.find_or_create_by_name(tag_name)
                    tag = Tag.find_or_initialize_by_name(tag_name)
                    tag.save(:validate => false) if tag.new_record?
                    
                    if (params[:add])
                        updaters.each do |item|
                            unless (item.tags.include?(tag))
                                item.tags << tag
                                item.save
                            end
                        end
                        notice = "Items have been tagged."
                    elsif (params[:remove])
                        updaters.each do |item|
                            item.tags.delete(tag)
                            item.save
                        end
                        notice = "Tags have been removed from items.."
                    end
                end
            end
        else
            notice = "You didn't select any items."
        end
        @items = Item.all
        redirect_to items_path(:search => params[:search]), :notice => notice
    end
    
    def create
        @item = Item.new(params[:item])
        if @item.save
            redirect_to items_path(:search => @item.name), :notice => 'Item was successfully created.'
        else
            @tags = Tag.item_tags
            render :action => "new"
        end
    end

    def update
        @item = Item.find(params[:id])

        if @item.update_attributes(params[:item])
            @items = Item.all
            redirect_to items_path(:search => @item.name), :notice => 'Item was successfully updated.'
        else
            @tags = Tag.item_tags
            render :action => "edit"
        end
    end

    def destroy
        @item = Item.find(params[:id])
        @item.destroy

        redirect_to items_url
    end
    
    def validate
        Item.find(:all).each do |item|
            item.update_attribute(:rules_validate, item.valid?)
            item.update_attribute(:updated_at,Time.now)
        end
        redirect_to items_path, :notice => 'Re-validated all items.'
    end
    
end
