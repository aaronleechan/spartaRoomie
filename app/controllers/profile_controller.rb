class ProfileController < ApplicationController
    before_action :authenticate_user!
    
    def index
        if current_user.text_post.first != nil
            @aboutMe = current_user.text_post.first
        else
            @aboutMe = current_user.text_post.new
        end
        
        if current_user.image_posts != nil
            @slideShow = current_user.image_posts.all
        else
            @slideShow = current_user.image_posts.new
        end
    end
    
    def show
        if current_user.text_post.first != nil
            @aboutMe = current_user.text_post.first
        else
            @aboutMe = current_user.text_post.new
        end
        
        if current_user.image_posts != nil
            @slideShow = current_user.image_posts.all
        else
            @slideShow = current_user.image_posts.new
        end
    end
end