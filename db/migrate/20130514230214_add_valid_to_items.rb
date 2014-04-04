class AddValidToItems < ActiveRecord::Migration
    def up
        change_table :items do |t|
            t.boolean :rules_validate, :default => true
        end
        Item.update_all ["rules_validate = ?", true]
    end
    
    def down
        remove_column :items, :rules_validate
    end
end
