class VideosController < ApplicationController
  before_action :find_video, only: %i[show like deslike destroy edit update denounce]
  before_action :authenticate_channel!, except: %i[show denounce]

  def new
    @video = Video.new
  end

  def create
    @video = current_channel.videos.new(video_params)

    if @video.save
      redirect_to @video
      flash[:success] = "#{@video.title} foi enviado com sucesso"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    return unless @video.destroy

    flash[:success] = "O video #{@video.title} foi excluido"
    redirect_to root_path
  end

  def edit; end

  def update
    return unless @video.update(video_params)

    redirect_to @video
    flash[:notice] = "#{@video.title} foi editado com sucesso"
  end

  def show
    @videos = Video.all
  end

  def like
    @video.like
    redirect_to @video
  end

  def deslike
    @video.dislike
    redirect_to @video
  end

  def denounce
    @video.denounce

    if @video.denounces >= 5
      @video.destroy
      flash[:notice] = "O video #{@video.title} foi excluido por conter muitas denuncias"
      redirect_to root_path
    else
      redirect_to @video
    end
  end

  private

  def video_params
    extracted_video_id = YouTubeAddy.extract_video_id(params[:video][:video_url])
    params.require(:video).permit(:title, :description, :channel_id, :video_url).merge(identity: extracted_video_id)
  end

  def find_video
    @video = Video.friendly.find(params[:id])
  end
end
