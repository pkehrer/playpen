class PasswordsController < ApplicationController
  before_filter :verify_user

  def index
    @passes = current_user.passes
  end

  def new
    @pass = Pass.new
  end

  def create
    pass = Pass.new(pass_params)
    pass.user = current_user
    pass.save
    redirect_to action: "index"
  end

  private
  def pass_params
    params.require(:pass).permit(:name, :password, :notes)
  end

end
