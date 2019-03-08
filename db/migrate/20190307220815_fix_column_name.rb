class FixColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :rests, :type, :description
  end
end
