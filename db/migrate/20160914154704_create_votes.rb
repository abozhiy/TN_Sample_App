class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.reference :votable, polymorphic: true
      t.belongs_to :user, index: true, foreign_key: true
      t.integer :rating

      t.timestamps
    end
  end
end
