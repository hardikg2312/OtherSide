class Api::V1::UsersController < Api::V1::MainController

  def index
    render :json => { result: "hello every one"}
  end
end