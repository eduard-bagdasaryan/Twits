class TwitsController < ApplicationController
    before_action :authenticate, except: [ :index, :destroy]

    def index
        @twits = Twit.joins(:user).select('users.name, twits.*')
    end

    def create
        @user = User.where(token: @token).first
        @twit = @user.twits.create(twit_params)
        @twit.vote = 0
        @twit.save
        redirect_to twits_path
    end

    def update
        @twit = Twit.find(params[:id])
        @twit.update_attribute(:vote, @twit.vote + 1)
        redirect_to twits_path
    end

    def destroy
        @twit = Twit.find(params[:id])
        @twit.destroy
        redirect_to twits_path
    end

    private

    def twit_params
        params.require(:twit).permit(:message, :string)
    end

    def authenticate
        authenticate_or_request_with_http_token do |token, options|
            User.find_by(token: token)
            @token = token;
        end
    end

    private

    @token = '';
end
