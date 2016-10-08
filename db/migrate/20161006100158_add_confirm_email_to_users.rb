class AddConfirmEmailToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :confirmation_email, :string
    add_column :users, :confirm_email, :boolean, default: false
  end
end
