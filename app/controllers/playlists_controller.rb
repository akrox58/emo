class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
  
    @playlists = Playlist.all
@raters=Rater.all
@songs = Song.all
    respond_with(@playlists,@songs,@raters)
  end

  def show
     
   @songs=Song.where(:mood_id=>@playlist.mood)
    respond_with(@playlist)
  end

  def new
    @playlist = Playlist.new
    
    respond_with(@playlist)
  end

  def edit
  end

  def create
    @playlist = Playlist.new(playlist_params)
    @playlist.save
    respond_with(@playlist)
  end

  def update
    @playlist.update(playlist_params)
    respond_with(@playlist)
  end

  def destroy
    @playlist.destroy
    respond_with(@playlist)
  end

  private
    def set_playlist
      @playlist = Playlist.find(params[:id])
    end

    def playlist_params
<<<<<<< HEAD
#get code here,put finish.txt,testemo.py into folder
params.require(:playlist).permit(:name, :mood_id, :user_id)
	end
	end
=======
      params.require(:playlist).permit(:mood_id, :user_id, :name)
    end
end
>>>>>>> 92678991e2b7bd85dba3cf56482541c82b4703ea
