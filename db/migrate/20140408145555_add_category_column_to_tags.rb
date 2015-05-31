class AddCategoryColumnToTags < ActiveRecord::Migration
    def change
        change_table :tags do |t|
            t.integer :category_id
        end
    end
end
