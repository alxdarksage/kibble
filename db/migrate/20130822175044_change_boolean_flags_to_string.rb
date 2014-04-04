class ChangeBooleanFlagsToString < ActiveRecord::Migration
    def up
        remove_column :tags, :is_trait
        remove_column :tags, :is_item_tag
        add_column :tags, :rel, :string, :default => "item"
    end

    def down
        remove_column :tags, :rel
        add_column :tags, :is_trait, :boolean
        add_column :tags, :is_item_tag, :boolean, :default => true
    end
end
