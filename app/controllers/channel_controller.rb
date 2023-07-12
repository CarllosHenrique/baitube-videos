class ChannelController < ApplicationController
  before_action :authenticate_channel!, only: [:profile]

  def profile; end

  def channel
    @channel = Channel.friendly.find(params[:id])

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

  private

  def user_params
    params.require(:channel).permit(:name, :about, :avatar)
  end
end
