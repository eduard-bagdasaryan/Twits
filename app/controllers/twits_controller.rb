class TwitsController < CommonController

    def index
        @twits = Twit.twits_all 
    end

    def create
        @twit = @user.twits.create(twit_params)
        @twit.save
        redirect_to twits_path
    end

    def update
        @twit = Twit.find(params[:id])
        @twit.increment!(:vote)
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

end
