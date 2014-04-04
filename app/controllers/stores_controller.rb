class StoresController < ApplicationController
    
    # Item.includes(:tags).where(:tags => {:name => 'firearm'})
    def index
        @stores = Store.order(:name).find(:all)
        @stores = Kaminari.paginate_array(@stores).page(params[:page]).per(30)
    end

    def show
        @store = Store.find(params[:id])
        @tags = Tag.store_tags
    end

    def new
        @store = Store.new
        @tags = Tag.store_tags
    end
    
    def clone
        @clone = Store.find(params[:id])
        @store = Store.new(@clone.attributes)
        @clone.tags.each do |tag|
            @store.tags << tag
        end
        @tags = Tag.store_tags
        render "new"
    end

    def edit
        @store = Store.find(params[:id])
        @tags = Tag.store_tags
    end

    def create
        @store = Store.new(params[:store])
        if @store.save
            redirect_to stores_path, :notice => 'Store was successfully created.'
        else
            @tags = Tag.store_tags
            render :action => "new"
        end
    end

    def update
        @store = Store.find(params[:id])

        if @store.update_attributes(params[:store])
            @stores = Store.all
            redirect_to stores_path, :notice => 'Store was successfully updated.'
        else
            @tags = Tag.store_tags
            render :action => "edit"
        end
    end

    def destroy
        @store = Store.find(params[:id])
        @store.destroy

        redirect_to stores_url
    end
    
end
