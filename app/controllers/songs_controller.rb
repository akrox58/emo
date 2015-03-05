class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @songs = Song.all
    respond_with(@songs)
  end

  def search
	@songs = Song.where(mood_id: params[:mood])
  end


  def show
    respond_with(@song)
  end

  def new
    @song = Song.new
    respond_with(@song)
  end

  def edit
  end

	def listening
	@rater=Rater.find(params[:id])
	@rater.count=@rater.count+1
	@rater.save
	#		respond_to do |format|
      	#	format.js
	#end'
	render :text => 'Done' 
	end


def listofsong
	@moods = Mood.all
@raters=Rater.all
@songs = Song.all
    respond_with(@songs,@raters)
  end


def mp3player
@songs = Song.all
    respond_with(@songs)
  end

  def create
    @song = Song.new(song_params)
    @song.save
    respond_with(@song)
  end

  def update
    @song.update(song_params)
    respond_with(@song)
  end

  def destroy
    @song.destroy
    respond_with(@song)
  end

  private
    def set_song
      @song = Song.find(params[:id])
    end

    def song_params
      params.require(:song).permit(:name, :mood_id, :artist_id, :audio)
    end
end
