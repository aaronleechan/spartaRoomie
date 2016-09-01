class TextPostsController < ApplicationController
    def index
        if current_user.text_post.first != nil
            @aboutMe = current_user.text_post.first
        else
            @aboutMe = current_user.text_post.new
        end
    end
    
    def show
        if current_user.text_post.first != nil
            @aboutMe = current_user.text_post.first
        else
            @aboutMe = current_user.text_post.new
        end
    end
end
