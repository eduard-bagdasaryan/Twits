class CommonController < ApplicationController
    before_action :authenticate, except: [ :index, :destroy ]

private
    def authenticate
        authenticate_or_request_with_http_token do |token, options|
            @user = User.find_by(token: token)
        end
    end

end
