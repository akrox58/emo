class RatersController < ApplicationController
before_action :set_rater, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    @songs = Song.all
	@raters=Rater.all
    respond_with(@songs,@raters)
  end
def edit
end
 def show
   @raters=Rater.where(:mood_id=>@rater.mood.id , :user_id => current_user.id, :play => 1)
    respond_with(@rater)
  end

def up
@rcurrent=Rater.where(song_id: params[:id], :user_id => current_user.id).take
r=Reccommender.where(user_id: current_user.id).first

if @rcurrent.mood_id==1
	@rrecom=Rater.where(song_id: params[:id], :user_id => r.happy).take	
	if @rcurrent.mood_id != @rrecom.mood_id
		@rcurrent.mood_id=@rrecom.mood_id

	else
			
		 @rcurrent.mood_id= rand(1..5)

		end


	


elsif @rcurrent.mood_id==2
	@rrecom=Rater.where(song_id: params[:id], :user_id => r.sad).take	
	if @rcurrent.mood_id != @rrecom.mood_id
		@rcurrent.mood_id=@rrecom.mood_id

	else	
		 @rcurrent.mood_id= rand(1..5)

		end


	



elsif @rcurrent.mood_id==3
	@rrecom=Rater.where(song_id: params[:id], :user_id => r.angry).take	
	if @rcurrent.mood_id != @rrecom.mood_id
		@rcurrent.mood_id=@rrecom.mood_id

	else	
			 @rcurrent.mood_id=  rand(1..5)
		


	end


elsif @rcurrent.mood_id==4
	@rrecom=Rater.where(song_id: params[:id], :user_id => r.fear).take	
	if @rcurrent.mood_id != @rrecom.mood_id
		@rcurrent.mood_id=@rrecom.mood_id

	else			
			 @rcurrent.mood_id=  rand(1..5)

		


	end


elsif @rcurrent.mood_id==5
	@rrecom=Rater.where(song_id: params[:id], :user_id => r.surprise).take	
	if @rcurrent.mood_id != @rrecom.mood_id
		@rcurrent.mood_id=@rrecom.mood_id

	else		
		 @rcurrent.mood_id= rand(1..5)

		


	end


end


	@rcurrent.play=1
	@rcurrent.save

	render :text => 'Done' 
end

def upp
@rater=Rater.where(song_id: params[:id], user_id: current_user.id).take
	@rater.play=0
	@rater.save
	render :text => 'Done' 

end

def uppp
@rater=Rater.where(song_id: params[:id], user_id: current_user.id).take
	@rater.play=1
	@rater.save
	render :text => 'Done' 


end



def signup
@songs=Song.all
@songs.each do |song|
 Rater.create(song_id: song.id , user_id: current_user.id, count: 0, mood_id: song.mood_id, search: 0, play: 1)
end

uu=User.all
uu.each do |user|
Reccommender.create(user_id: user.id,happy: 4, sad: 4, angry: 4, fear: 4,surprise: 4)
end


end


 def update
    @rater.update(rater_params)
    respond_with(@rater)
  end

private

def set_rater
@rater = Rater.find(params[:id])
    end

 def rater_params
      params.require(:rater).permit(:song_id, :user_id,:count,:mood_id, :search,:play)
    end

end
