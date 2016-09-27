class SongsController < ApplicationController
  def index

    # binding.pry
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])

      if @artist
          @songs = Artist.find(params[:artist_id]).songs
          render :index
      else
        flash[:alert] = "Artist not found."
        redirect_to artists_path
      # redirect_to songs_path
      end
    else
      @songs = Song.all
    end
  end



  def show
    # binding.pry
    if params[:artist_id]
        @artist = Artist.find(params[:artist_id])
        @song = @artist.songs.find_by(:id => params[:id])
        if @artist && @song
          @songs = @artist.songs
          # @songs = Song.all
        else
          flash[:alert] = "Song not found."
          redirect_to artist_songs_path(@artist)
        end
    else
      @song = Song.find(params[:id])
    end


    # if params[:artist_id]
    #   @songs = Artist.find(params[:artist_id]).songs
    #   # @songs = Song.all
    # else
    #   flash[:alert] = "Song not found."
    #   @songs = Song.all
    # end

  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end
