class ChannelController < ApplicationController
  before_action :authenticate_channel!, only: %i[profile]
  before_action :find_channel, only: %i[channel subscribe_channel unsubscribe_channel]

  def profile; end

  def channel
    return unless channel_signed_in? && @channel.slug == current_channel.slug

    redirect_to my_channel_path
  end

  def edit; end

  def update
    if current_channel.update(user_params)
      flash[:success] = "Você atualizou suas informaçoes com sucesso!"
      redirect_to my_channel_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def subscribe_channel
    @channel.subscribed_channels << current_channel.slug
    @channel.save
    redirect_to user_channel_path(@channel)
  end

  def unsubscribe_channel
    @channel.subscribed_channels.delete(current_channel.slug)
    @channel.save
    redirect_to user_channel_path(@channel)
  end

  private

  def find_channel
    @channel = Channel.friendly.find(params[:id])
  end

  def user_params
    params.require(:channel).permit(:name, :about, :avatar)
  end
end
