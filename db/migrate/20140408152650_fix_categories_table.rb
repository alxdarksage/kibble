class FixCategoriesTable < ActiveRecord::Migration
    def up
        create_table :categories2, :force => true do |t|
            t.string :name
            t.string :prefix
            t.string :available_for
            t.boolean :required
            t.boolean :exclusive
            t.timestamps
        end
        drop_table :categories
        rename_table :categories2, :categories
    end

    def down
        # do nothing.
    end
end
