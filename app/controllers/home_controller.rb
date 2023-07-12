class HomeController < ApplicationController
  def index
    @videos = Video.all

    @controls = [
      { "name" => "Inicio", "path" => root_path },
      { "name" => "Meu canal", "path" => my_channel_path },
      { "name" => "Fazer Upload", "path" => new_video_path }
    ]
  end
end
