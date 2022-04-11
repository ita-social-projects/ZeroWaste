class AddReceiveRecomendationsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :receive_recomendations, :boolean, default: false
  end
end
