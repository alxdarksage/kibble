class CreateStores < ActiveRecord::Migration
    def change
        create_table :stores do |t|
            t.string :name
            t.string :policy
            t.string :owner_profession
            t.string :owner_trait
            t.string :bag_query
            t.integer :bag_total_value
            t.timestamps
        end
    end
    
end
