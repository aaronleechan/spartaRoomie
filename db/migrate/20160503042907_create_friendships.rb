class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|

     	t.belongs_to :user
    	t.belongs_to :friend, class: 'User'
    	t.string :status
    	
      	t.timestamps
    end
  end
end
