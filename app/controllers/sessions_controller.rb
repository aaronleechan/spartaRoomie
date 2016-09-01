class SessionsController < ApplicationController
    def new
    end
    
    def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            if user.email_confirmed
                session[:user_id] = user.id
                user.increment!(:numLogIns)
                if user.numLogIns == 1
                    redirect_to update_path
                else
                    redirect_to root_url, notice: "Log in successful"
                end
            else
                render "new", notice: "Please verify your email address to continue."
            end
            
        else
            render "new", notice: "Invalid email/password combination"
        end
    end
    
    def destroy
        session[:user_id] = nil
        redirect_to root_url, notice: "Log out successful"
    end
end