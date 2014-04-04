class AddFunctionToProfessions < ActiveRecord::Migration
  def change
      add_column :professions, :function, :text
  end
end
