class Api::V1::UsersController < Api::V1::MainController

  before_filter :restrict_access, :only => []
  skip_before_filter :verify_authenticity_token, :only => [:create]

  def index
    render :json => { result: "hello every one"}
  end

  def create
  	if params[:email].blank? || params[:password].blank? || params[:password_confirmation].blank? || params[:user_name].blank?
      render :json => { errorcode: 2, errorstr: "Required parameters missing", result: []}
  	else
      user = User.new
      user.email = params[:email]
      user.password = params[:password]
      user.password_confirmation = params[:password_confirmation]
      user.user_name = params[:user_name]
      if user.save
        access_token = user.generate_access_token
        result = { "access_token" => access_token, "expires_at" => nil }
        render :json => { errorcode: 0, errorstr: "Success", result: result }
      else
        render :json => { errorcode: 1, errorstr: "Error", result: user.errors}
      end
    end
  end
end