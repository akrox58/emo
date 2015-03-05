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
     
   @raters=Rater.where(:mood_id=>@playlist.mood , :user_id => current_user.id)
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
statement = params[:playlist][:name]
    	
	`python testemo.py #{statement}`

	file = File.open("finish.txt", 'rb')                           #execute python code here and get the value into finish.txt
	while !file.eof?
		line = file.readline
		line=line.gsub(/\n/," ")
	end

	params = ActionController::Parameters.new({
playlist: {
name: statement, 
mood_id:line,
user_id: current_user.id
}
})
params.require(:playlist).permit(:name, :mood_id, :user_id)
	end
	end
