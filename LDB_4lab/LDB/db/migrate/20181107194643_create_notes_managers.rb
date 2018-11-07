class CreateNotesManagers < ActiveRecord::Migration[5.2]
  def change
    create_table :notes_managers do |t|

      t.timestamps
    end
  end
end
