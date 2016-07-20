class CreateFacts < ActiveRecord::Migration
  def change
    create_table :facts do |t|
      t.integer :organization_id
      t.integer :user_id
      t.string :name
      t.string :input
      t.string :readableId
    end
  end
end
