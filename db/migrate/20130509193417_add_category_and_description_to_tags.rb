class AddCategoryAndDescriptionToTags < ActiveRecord::Migration
    def change
        add_column :tags, :category, :string
        add_column :tags, :description, :text
    end
end
