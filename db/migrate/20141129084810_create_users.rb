class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_hash
      t.string :password_salt
      t.string :user_name
      t.string :access_token
      t.datetime :expires_at

      t.timestamps
    end
  end
end
