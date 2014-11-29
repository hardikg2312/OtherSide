class Api::V1::MainController < ApplicationController

  private
  
    def restrict_access
      authenticate_or_request_with_http_token do |token, options|
       @user = User.where(access_token: token).first
      end
    end
end