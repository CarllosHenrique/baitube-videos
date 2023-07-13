class AddLikeAndDeslikesToVideo < ActiveRecord::Migration[7.0]
  def change
    add_column :videos, :likes, :integer, default: 0
    add_column :videos, :deslikes, :integer, default: 0
  end
end
