class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @songs = Song.all
    respond_with(@songs)
  end

  def search


@moods=Mood.all
@raters=Rater.where(mood_id: params[:mood] ,:user_id => current_user.id, :play => 1)
recomotheruser=Rater.where("mood_id=? and user_id<> ?",params[:mood],current_user.id)

recomuser=Rater.where("mood_id<>? and user_id=?",params[:mood],current_user.id)

groupedset=recomotheruser.where("song_id IN (select song_id from raters where mood_id=? and user_id=?)",params[:mood],current_user.id)

f1=groupedset.select("user_id,mood_id,song_id,count(*) as total_count").group(:user_id).order("total_count DESC").first

u=Reccommender.where(user_id: current_user.id).take

unless f1.nil?
if f1.mood_id == 1
u.update( happy: f1.user_id )
elsif f1.mood_id ==2
u.update( sad: f1.user_id )
elsif f1.mood_id ==3
u.update( angry: f1.user_id )
elsif f1.mood_id ==4
u.update( fear: f1.user_id )
elsif f1.mood_id ==5
u.update( surprise: f1.user_id )
end
u.save
end



# recommended for searched songs

f22=groupedset.select("user_id,mood_id,song_id,count(*) as total_count").group(:user_id).order("total_count DESC").limit(5)

r=Rater.where(user_id=0)
f22.each do |u|
	recc=recomuser.where("song_id IN (select song_id from raters where mood_id=? and user_id=?)", params[:mood],u.user_id)
		r=r|recc
end

   raters=Rater.where(:mood_id=>params[:mood] , :user_id => current_user.id, :play => 1)
   popu=Rater.where("song_id IN (select song_id from populars order by count desc limit 20) and user_id=? and mood_id <> ? ",current_user.id, params[:mood])

popoose=popu.where("count = 0 or search = 0 and user_id=? and mood_id <> ? ",current_user.id, params[:mood]).take(5)
popu=popu.take(10)
@rec = r|popu|popoose



  end


  def show
	Popular.create(song_id: params[:id], count: 0)
  @text = File.read("word.txt") do  |f| 
     f.each_line do  |line| 
      @text = @text.to_s + '<br>'+line.to_s 
      end 
    end
puts @text
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
   songname = @song.name
    artistname = @song.artist.artistname
     #tatementa = params[:song][:artistname]
     st1=artistname.gsub(" ","_")
     
    #tatementt =params[:song][:songname]
     st2=songname.gsub(" ","_")
    
    `python3 crawl.py #{st1} #{st2}`
 
   `python def.py`
      file = File.open("result.txt", 'rb')                           
	while !file.eof?
		line1 = file.readline
                
		#line1=line.gsub(/\n/," ")
	end
   
    
    @song.mood_id=line1
    @song.save
    respond_with(@song)
  end

  def update
    @song.update(song_params)
    respond_with(@song)
  end

  def destroy
	Popular.where(song_id: @song.id).delete
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
