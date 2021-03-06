class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Сообщение отправлено!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Сообщение удалено"
    redirect_to request.referrer || root_url
  end

  def show
    @reply = current_user.microposts.build
    @micropost = Micropost.find(params[:id])
    @user = @micropost.user
    @reply.content = "Ответ на: " + url_for([@micropost]) + "\n "
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end

end
