class Api::V1::SessionsController < Api::V1::MainController

  skip_before_filter :verify_authenticity_token, :only => [:create]

  def create
    if params[:email].blank? || params[:password].blank?
      render :json => { errorcode: 2, errorstr: "Required parameters email and password", result: []}
    else
      if user = User.authenticate(params[:email], params[:password])
        access_token = User.generate_access_token
        user.update_attributes(:access_token => access_token)
        result = { "access_token" => access_token, "expires_at" => nil }
        render :json => { errorcode: 0, errorstr: "Success", result: result }
      else
        render :json => { errorcode: 1, errorstr: "Invalid Email or password", result: []}
      end
    end
  end

end