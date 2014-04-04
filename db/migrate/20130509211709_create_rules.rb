class CreateRules < ActiveRecord::Migration
    def change
        create_table :rules do |t|
            t.string :identifier
            t.text :parameters

            t.timestamps
        end
    end
end
