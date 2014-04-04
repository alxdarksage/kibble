class CreateProfessionsTraitsTable < ActiveRecord::Migration
    def change
        create_table :professions_traits, :id => false do |t|
            t.integer :profession_id
            t.integer :tag_id
        end
    end
end
