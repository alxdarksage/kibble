class CreateProfessionsTagsTable < ActiveRecord::Migration
    def change
        create_table :professions_tags, :id => false do |t|
            t.integer :profession_id
            t.integer :tag_id
        end
    end
end
