class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @raters=Rater.where(:user_id => current_user.id, :play => 1)
    respond_with(@playlists,@raters)
  end

  def show

  popu=Rater.where("song_id IN (select song_id from populars order by count desc limit 10) and user_id=?",@playlist.user_id)
   

@moods=Mood.all
recom=Rater.where.not(:user_id => current_user.id)

recomuser=Rater.where("mood_id<>? and user_id=?",@playlist.mood,current_user.id)

recom2=recom.where(mood_id:  @playlist.mood)

set=recom2.where("song_id IN (select song_id from raters where mood_id=? and user_id=?)",@playlist.mood,current_user.id)

@f2=set.select("user_id,mood_id,song_id,count(*) as total_count").group(:user_id).order("total_count DESC").limit(3)
u1=@f2.offset(1).first
u2=@f2.offset(2).first
u3=@f2.offset(3).first
reccomending=recomuser.where("song_id IN (select song_id from raters where mood_id=? and user_id IN (?,?,?))", @playlist.mood,u1.user_id,u2.user_id,u3.user_id)


   raters=Rater.where(:mood_id=>@playlist.mood , :user_id => current_user.id)
   pop=raters.order(count: :desc,search: :desc).take(10)

@rec = pop | reccomending | popu
    respond_with(@playlist,@rater)
 
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
    	
	`python rosh.py #{statement}`

	file = File.open("finish.txt", 'rb')                           #execute python code here and get the value into finish.txt
	while !file.eof?
		line = file.readline
		line=line.gsub(/\n/," ")
	end

	params = ActionController::Parameters.new({
playlist: {
name: statement, 
mood_id: line,
user_id: current_user.id
}
})
params.require(:playlist).permit(:name, :mood_id, :user_id)
	end
	end
