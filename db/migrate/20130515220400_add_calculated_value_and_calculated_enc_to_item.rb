class AddCalculatedValueAndCalculatedEncToItem < ActiveRecord::Migration
    def up
        change_table :items do |t|
            t.decimal :calculated_value
            t.decimal :calculated_enc
        end
    end
    
    def down
        remove_column :items, :calculated_value
        remove_column :items, :calculated_enc
    end
end
