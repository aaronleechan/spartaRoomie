class AddAddressToImages < ActiveRecord::Migration
  def change
  	add_column :images, :information, :text
  end
end
