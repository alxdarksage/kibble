class AddMinMaxValuesToStores < ActiveRecord::Migration
    def change
        change_table :stores do |t|
            t.integer :bag_min_value
            t.integer :bag_max_value
        end
    end
end
