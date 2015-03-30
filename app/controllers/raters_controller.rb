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

popu=Rater.where("song_id IN (select song_id from populars order by count desc limit 10) and user_id=?",@rater.user_id)
@moods=Mood.all

recom=Rater.where("mood_id=? and user_id<> ?",@rater.mood_id,current_user.id)
set=recom.where("song_id IN (select song_id from raters where mood_id=? and user_id=?)",@rater.mood_id,current_user.id)
f2=set.select("user_id,mood_id,song_id,count(*) as total_count").group(:user_id).order("total_count DESC").limit(3)

u1=f2.offset(1).first
u2=f2.offset(2).first
u3=f2.offset(3).first

recomuser=Rater.where("mood_id<>? and user_id=?",@rater.mood_id,current_user.id)

reccomending=recomuser.where("song_id IN (select song_id from raters where mood_id=? and user_id IN (?,?,?))", @rater.mood,u1.user_id,u2.user_id,u3.user_id)


   raters=Rater.where(:mood_id=>@rater.mood , :user_id => current_user.id, :play => 1)
   pop=raters.order(count: :desc, search: :desc).take(10)

@rec = pop | reccomending | popu

    respond_with(@rater)
  end


def up

rcurr=Rater.where(song_id: params[:id], :user_id => current_user.id).take
r=Reccommender.where(user_id: current_user.id).first

if rcurr.mood_id==1
	rrec=Rater.where(song_id: params[:id], :user_id => r.happy).take	
	if rcurr.mood_id != rrec.mood_id
		rcurr.mood_id=rrec.mood_id

	else
			
		 rcurr.mood_id= rand(1..5)

		end


	


elsif rcurr.mood_id==2
	rrec=Rater.where(song_id: params[:id], :user_id => r.sad).take	
	if rcurr.mood_id != rrec.mood_id
		rcurr.mood_id=rrec.mood_id

	else	
		 rcurr.mood_id= rand(1..5)

		end


	



elsif rcurr.mood_id==3
	rrec=Rater.where(song_id: params[:id], :user_id => r.angry).take	
	if rcurr.mood_id != rrec.mood_id
		rcurr.mood_id=rrec.mood_id

	else	
			 rcurr.mood_id=  rand(1..5)
		


	end


elsif rcurr.mood_id==4
	rrec=Rater.where(song_id: params[:id], :user_id => r.fear).take	
	if rcurr.mood_id != rrec.mood_id
		rcurr.mood_id=rrec.mood_id

	else			
			 rcurr.mood_id=  rand(1..5)

		


	end


elsif rcurr.mood_id==5
	rrec=Rater.where(song_id: params[:id], :user_id => r.surprise).take	
	if rcurr.mood_id != rrec.mood_id
		rcurr.mood_id=rrec.mood_id

	else		
		 rcurr.mood_id= rand(1..5)

		


	end


end


	rcurr.play=1
	rcurr.save

	render :text => 'Done' 
end

def upp
rater=Rater.where(song_id: params[:id], user_id: current_user.id).take
	rater.play=0
	rater.save
	render :text => 'Done' 

end

def uppp
rater=Rater.where(song_id: params[:id], user_id: current_user.id).take
	rater.play=1
	rater.save
	render :text => 'Done' 


end



def signup
songs=Song.all
songs.each do |song|
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
