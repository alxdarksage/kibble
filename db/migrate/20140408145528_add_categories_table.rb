class AddCategoriesTable < ActiveRecord::Migration
    def change
        create_table :categories, :force => true do |t|
            t.string :name
            t.string :prefix
            t.string :available_for
            t.boolean :required
            t.boolean :exclusive
        end
    end
end
