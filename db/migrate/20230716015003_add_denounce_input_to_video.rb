class AddDenounceInputToVideo < ActiveRecord::Migration[7.0]
  def change
    add_column :videos, :denounces, :integer, default: 0
  end
end
