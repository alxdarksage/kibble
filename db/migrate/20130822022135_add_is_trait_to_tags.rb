class AddIsTraitToTags < ActiveRecord::Migration
    def change
        add_column :tags, :is_trait, :boolean
    end
end
