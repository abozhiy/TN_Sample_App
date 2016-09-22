class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.references :votable, polymorphic: true
      t.integer :rating
      t.integer :user_id
      t.integer :votable_id

      t.timestamps
    end

    add_index :votes, [:user_id, :votable_id, :votable_type]
  end
end
