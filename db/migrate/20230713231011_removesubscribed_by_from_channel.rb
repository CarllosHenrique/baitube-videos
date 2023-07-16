class RemovesubscribedByFromChannel < ActiveRecord::Migration[7.0]
  def change
    remove_column :channels, :subscribed_by
  end
end
