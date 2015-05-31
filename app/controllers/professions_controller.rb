class ProfessionsController < ApplicationController
    
    def index
        # This didn't work using ActiveRecord, so disabled that for the moment. Have no idea
        # how to do this efficiently for multiple search criteria, using AR.
        @professions = Profession.includes(:tags).order(:name).all
        if (params[:searchp] || cookies[:searchp])
            (params[:searchp] || cookies[:searchp]).split(/\s/).each do |term|
                value = (term.include?(":")) ? term[(term =~ /:/)+1,term.length] : term
                if (term.start_with?("-tag:"))
                    @professions = @professions.select {|item| !item.tags.pluck(:name).include?(value)}
                elsif (term.start_with?("tag:"))
                    @professions = @professions.select {|item| item.tags.pluck(:name).include?(value)}
                else
                    @professions = @professions.select {|item| item.name.include?(term)}
                end
            end
        end
        #@professions = Kaminari.paginate_array(@professions).page(params[:page]).per(30)
    end

    def show
        @profession = Profession.find(params[:id])
        @tags = Tag.profession_tags
        @traits = Tag.trait_tags
    end

    def new
        @profession = Profession.new
        @tags = Tag.profession_tags
        @traits = Tag.trait_tags
    end
    
    def clone
        @clone = Profession.find(params[:id])
        @profession = Profession.new(:name => @clone.name, :function => @clone.function)
        @clone.tags.each do |tag|
            @profession.tags << tag
        end
        @clone.seeds.each do |seed|
            @profession.seeds << seed
        end
        @clone.traits.each do |trait|
            @profession.traits << trait
        end
        @tags = Tag.profession_tags
        @traits = Tag.trait_tags
        render "new"
    end

    def edit
        @profession = Profession.find(params[:id])
        @tags = Tag.profession_tags
        @traits = Tag.trait_tags
    end
    
    def create
        @profession = Profession.new(params[:profession])
        if @profession.save
            redirect_to professions_path(:search => @profession.name), :notice => 'Profession was successfully created.'
        else
            @tags = Tag.order(:cat, :name).find(:all)
            render :action => "new"
        end
    end

    def update
        @profession = Profession.find(params[:id])

        if @profession.update_attributes(params[:profession])
            @professions = Profession.all
            redirect_to professions_path(:search => @profession.name), :notice => 'Profession was successfully updated.'
        else
            @tags = Tag.order(:cat, :name).find(:all)
            render :action => "edit"
        end
    end

    def destroy
        @profession = Profession.find(params[:id])
        @profession.destroy

        redirect_to professions_url
    end
    
end
