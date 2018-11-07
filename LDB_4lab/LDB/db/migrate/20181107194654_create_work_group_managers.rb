class CreateWorkGroupManagers < ActiveRecord::Migration[5.2]
  def change
    create_table :work_group_managers do |t|

      t.timestamps
    end
  end
end
