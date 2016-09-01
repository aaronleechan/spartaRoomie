class UsersController < ApplicationController
    before_action :authenticate_user!, except: [:new, :create, :index, :confirm_email]


    def new
        @user = User.new
    end

    def images
        user = User.find(params[:id])
        @images = User.find(params[:id]).images
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            UserMailer.registration_confirmation(@user).deliver
            redirect_to root_url, notice: "Please verify your email address to continue."
            numlogIns = 0
        else
            render "new"
        end
    end

    def index
	   @users = User.all
    end

    def show
        if(params[:id] == nil)
            @user = current_user
        else
            @user = User.find(params[:id])
            @images = User.find(params[:id]).images
            @friendship = Friendship.find_by_user_id_and_friend_id(current_user, @user)
        end
    end
    
    def edit
        @user = User.find(current_user)
    end
    
    def update
        @user = User.find(current_user)
        if @user.update_attributes(user_params)
            redirect_to root_url
        else
            render 'edit'
        end
    end

    def find
        @foundUsers = Array.new
        User.all.each do |user|
            count = 0
            if(user != current_user)
                if(user.gender == current_user.gender)
                    if (!current_user.hasPlace && user.hasPlace) || (current_user.hasPlace && !user.hasPlace)
                        count+=1
                    end

                    if current_user.shared == user.shared
                        count+=1
                    end

                    if (user.organization != nil && current_user.organization != nil && user.organization >= current_user.organization - 1 && user.organization <= current_user.organization + 1)
                        count+=1
                    end

                    if (user.cleanliness != nil && current_user.cleanliness != nil && user.cleanliness >= current_user.cleanliness - 1 && user.cleanliness <= current_user.cleanliness + 1)
                        count+=1
                    end

                    if (user.party != nil && current_user.party != nil && user.party >= current_user.party - 1 && user.party <= current_user.party + 1)
                        count+=1
                    end

                    if (user.drink != nil && current_user.drink != nil && user.drink >= current_user.drink - 1 && user.drink <= current_user.drink + 1)
                        count+=1
                    end

                    if (user.outgoing != nil && current_user.outgoing != nil && user.outgoing >= current_user.outgoing - 1 && user.outgoing <= current_user.outgoing + 1)
                        count+=1
                    end

                    if (current_user.drugs == user.drugs)
                        count+=1
                    end

                    if (current_user.smoking == user.smoking)
                        count+=1
                    end

                    if(count >= 4)
                        @foundUsers << user
                    end
                end
            end
        end
    end

    
    def home
        redirect_to current_user
    end

    def confirm_email
        user = User.find_by_confirm_token(params[:id])

        if user
            user.email_activate
            redirect_to root_url, notice: "Your email has been verified!"
        else
            redirect_to root_url, notice: "Error. User doesn't exist."
        end
    end
    
    private
    def user_params
        params.require(:user).permit(:firstName, :lastName, :email, :password_digest, :password, :password_confirmation,
                                     :school, :year, :gradSeason, :gradYear, :gender, 
                                     :birthdate, :hasPlace, :shared, :budget, :organization, :cleanliness,
                                     :party, :drink, :drugs, :smoking, :outgoing, :numLogIns, :avatar, :text)
    end
end