class MessagesController < ApplicationController
  def index
    @messages = Message.all.page(params[:page])
  end
  
  
  def show
    @message = Message.find(params[:id])
  end
  
  def new
    @message = Message.new
  end
  
  def create
    @message = Message.new(message_params)
    if @message.save
      flash[:success] = 'Messageが正常に投稿されました。'
      redirect_to @message
    else
      flash.now[:danger] = 'Messageが投稿されませんでした。'
      render :new
    end
  end
     
  def edit
    @message = Message.find(params[:id])
  end
  
  def update
    @message = Message.find(params[:id])

    if @message.update(message_params)
      flash[:success] = 'Message は正常に更新されました'
      redirect_to @message
    else
      flash.now[:danger] = 'Message は更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    flash[:success] = 'Message は正常に削除されました'
    redirect_to messages_url
  end
  
  private
      # Strong Parameter
  def message_params
    params.require(:message).permit(:content, :title)
  end
end
