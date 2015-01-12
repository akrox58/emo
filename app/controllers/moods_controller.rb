class MoodsController < ApplicationController
  before_action :set_mood, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @moods = Mood.all
    respond_with(@moods)
  end

  def show
    respond_with(@mood)
  end

  def new
    @mood = Mood.new
    respond_with(@mood)
  end

  def edit
  end

  def create
    @mood = Mood.new(mood_params)
    @mood.save
    respond_with(@mood)
  end

  def update
    @mood.update(mood_params)
    respond_with(@mood)
  end

  def destroy
    @mood.destroy
    respond_with(@mood)
  end

  private
    def set_mood
      @mood = Mood.find(params[:id])
    end

    def mood_params
      params.require(:mood).permit(:moodname)
    end
end
