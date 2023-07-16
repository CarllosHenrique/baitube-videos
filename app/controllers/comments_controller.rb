class CommentsController < ApplicationController
  before_action :authenticate_channel!, only: %i[create]

  def create
    @video = Video.friendly.find(params[:video_id])
    @comment = @video.comments.build(comment_params)
    @comment.channel = current_channel

    if @comment.save
      redirect_to @video
    else
      redirect_to @video
      flash[:notice] = "Erro ao enviar comentario"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
