class AddIsItemTagToTags < ActiveRecord::Migration
    def change
        add_column :tags, :is_item_tag, :boolean, :default => true
    end
end
