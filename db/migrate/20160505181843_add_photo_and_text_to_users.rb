class AddPhotoAndTextToUsers < ActiveRecord::Migration
  def change
  	  	add_column :users, :avatar, :string
  		add_column :users, :text,  :text
  end
end
