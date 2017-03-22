class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :username
      t.string :name
      t.string :token
      t.string :avatar
      t.string :provider

      t.timestamps
    end
  end
end
