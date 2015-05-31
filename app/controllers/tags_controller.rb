class TagsController < ApplicationController
    
    def index
        session[:tag_filter] = params[:filter] if params.has_key?(:filter)
        filter = session[:tag_filter]
        if (filter == 'professions')
            @tags = Tag.profession_tags + Tag.trait_tags
        elsif (filter == 'encounters')
            @tags = Tag.encounter_tags
        elsif (filter == 'stores')
            @tags = Tag.store_tags
        else
            @tags = Tag.item_tags
        end
    end

    def show
        @tags = Tag.find(params[:id])
        render "index"
    end

    def new
        @tag = Tag.new
    end

    def edit
        @tag = Tag.find(params[:id])
    end

    def create
        @tag = Tag.new(params[:tag])

        if @tag.save
            redirect_to tags_url, :notice => 'Tag was successfully created.'
        else
            render :action => "new"
        end
    end

    def update
        @tag = Tag.find(params[:id])

        if @tag.update_attributes(params[:tag])
            redirect_to tags_url, :notice => 'Tag was successfully updated.'
        else
            render :action => "edit"
        end
    end

    def destroy
        @tag = Tag.find(params[:id])
        @tag.destroy

        @tags = Tag.order(:cat, :name).all
        redirect_to tags_url, :notice => 'Tag was deleted.'
    end
    
end
