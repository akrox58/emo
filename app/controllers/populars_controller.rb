class PopularsController < ApplicationController
 before_action :set_popular, only: [:show, :edit, :update, :destroy]

  respond_to :html

def index
    @populars = Popular.all
    respond_with(@populars)
  
end


def edit
end
def show
end
def destroy
end
def new
end



private
    def set_popular
      @popular = Popular.find(params[:id])
    end

    def popular_params
      params.require(:popular).permit(:song_id, :count)
    end

end
