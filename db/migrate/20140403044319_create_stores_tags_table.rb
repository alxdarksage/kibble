class CreateStoresTagsTable < ActiveRecord::Migration
    def change
        create_table :stores_tags, :id => false do |t|
            t.integer :store_id
            t.integer :tag_id
        end
    end
end
