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
    respond_with(@rater)
  end

def up
@rater=Rater.where(song_id: params[:id], :user_id => current_user.id).take
	if @rater.mood_id == 5		
	@rater.mood_id= 1
else
@rater.mood_id=@rater.mood_id + 1
end
	@rater.play=1
	@rater.save

	render :text => 'Done' 


end

def upp
@rater=Rater.where(song_id: params[:id], :user_id => current_user.id).take
	@rater.play=0
	@rater.save
	render :text => 'Done' 


end

def uppp
@rater=Rater.where(song_id: params[:id], :user_id => current_user.id).take
	@rater.play=1
	@rater.save
	render :text => 'Done' 


end



def signup
@songs=Song.all
@songs.each do |song|
 Rater.create(song_id: song.id , user_id: current_user.id, count: 0, mood_id: song.mood_id, search: 0, play: 1)
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
