class AddEnabledToPatients < ActiveRecord::Migration[5.2]
  def change
    add_column :patients, :enabled, :boolean, default: true
  end
end
