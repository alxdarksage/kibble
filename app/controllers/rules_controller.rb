class RulesController < ApplicationController
    
    def index
        @rules = Rule.order(:identifier, :parameters).all
    end

    def show
        @rule = Rule.find(params[:id])
        render "index"
    end

    def new
        @rule = Rule.new
    end

    def edit
        @rule = Rule.find(params[:id])
    end

    def create
        @rule = Rule.new(params[:rule])

        if @rule.save
            redirect_to rules_url, :notice => 'Rule was successfully created.'
        else
            render :action => "new"
        end
    end

    def update
        @rule = Rule.find(params[:id])

        if @rule.update_attributes(params[:rule])
            redirect_to rules_url, :notice => 'Rule was successfully updated.'
        else
            render :action => "edit"
        end
    end

    def destroy
        @rule = Rule.find(params[:id])
        @rule.destroy

        @rules = Rule.order(:identifier, :parameters).all
        redirect_to rules_url, :notice => 'Rule was deleted.'
    end
    
end
