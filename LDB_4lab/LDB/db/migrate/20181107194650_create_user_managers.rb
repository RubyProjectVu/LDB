class CreateUserManagers < ActiveRecord::Migration[5.2]
  def change
    create_table :user_managers do |t|

      t.timestamps
    end
  end
end
