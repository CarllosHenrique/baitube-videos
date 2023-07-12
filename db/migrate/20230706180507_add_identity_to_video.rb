class AddIdentityToVideo < ActiveRecord::Migration[7.0]
  def change
    add_column :videos, :identity, :string
  end
end
