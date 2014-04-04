class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :value
      t.decimal :enc

      t.timestamps
    end
  end
end
