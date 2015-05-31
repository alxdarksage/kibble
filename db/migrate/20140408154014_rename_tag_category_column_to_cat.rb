class RenameTagCategoryColumnToCat < ActiveRecord::Migration
    def change
        rename_column :tags, :category, :cat
    end
end
