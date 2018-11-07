class CreateBudgetManagers < ActiveRecord::Migration[5.2]
  def change
    create_table :budget_managers do |t|

      t.timestamps
    end
  end
end
