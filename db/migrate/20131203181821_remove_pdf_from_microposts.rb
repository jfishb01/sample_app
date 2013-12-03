class RemovePdfFromMicroposts < ActiveRecord::Migration
  def change
    remove_column :microposts, :pdf, :attachment
  end
end
