class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @songs = Song.all
    respond_with(@songs)
  end

  def search

@raters=Rater.where(mood_id: params[:mood] , :user_id => current_user.id, :play => 1)
recom=Rater.where.not(:user_id => current_user.id)
recomuser=Rater.where("mood_id<>? and user_id=?",params[:mood],current_user.id)
recom2=recom.where(mood_id: params[:mood])


@set=recom2.where("song_id IN (select song_id from raters where mood_id=? and user_id=?)",params[:mood],current_user.id)

f1=@set.group(:user_id).first
rec=Reccommender.where(user_id: current_user.id).take
u=Reccommender.where(user_id: current_user.id).take

unless f1.nil?
if f1.mood_id == 1
rec.update( happy: f1.user_id )
@reccomending=recomuser.where("song_id IN (select song_id from raters where mood_id=1 and user_id=?)",u.happy)
elsif f1.mood_id ==2
rec.update( sad: f1.user_id )
@reccomending=recomuser.where("song_id IN (select song_id from raters where mood_id=2 and user_id=?)",u.sad)
elsif f1.mood_id ==3
rec.update( angry: f1.user_id )
@reccomending=recomuser.where("song_id IN (select song_id from raters where mood_id=3 and user_id=?)",u.angry)
elsif f1.mood_id ==4
rec.update( fear: f1.user_id )
@reccomending=recomuser.where("song_id IN (select song_id from raters where mood_id=4 and user_id=?)",u.fear)
elsif f1.mood_id ==5
rec.update( surprise: f1.user_id )
@reccomending=recomuser.where("song_id IN (select song_id from raters where mood_id=5 and user_id=?)",u.surprise)
end
rec.save
end




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
	render :text => 'Done' 
	end


	def pop
	@popular=Popular.where(:song_id => params[:id]).take
	@popular.count=@popular.count+1
	@popular.save
	render :text => 'Done' 
	end


	def listenin
	@rater=Rater.find(params[:id])
	@rater.search=@rater.search+1
	@rater.save
	render :text => 'Done' 
	end


def listofsong
@moods=Mood.all
@raters=Rater.where(:user_id => current_user.id)
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
