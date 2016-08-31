class SongsController < ApplicationController
  def index
    if params[:artist_id]
      if Artist.where(id: params[:artist_id]).empty?
        flash[:notice] = "Artist not found"
        redirect_to artists_path
      else
        @songs = Artist.find(params[:artist_id]).songs
      end
    else
      @songs = Song.all
    end
  end

  def show
    @song = Song.find_by(id: params[:id])
    @artist = Artist.find_by(id: params[:artist_id])
    if !@song 
      flash[:alert] = "Song not found"
      if @artist
        return redirect_to artist_songs_path(@artist)
      end
    end


    # if !Song.find_by(id: params[:id]) && !params[:artist_id]
    #   flash[:alert] = "Song not found"
    #   return redirect_to artists_path
    # elsif params[:artist_id] && !Song.find_by(id: params[:id])
    #   # if Artist.find_by(id: params[:artist_id])
    #     flash[:alert] = "Song not found"
    #     @artist = Artist.find(params[:artist_id])
    #     return redirect_to artist_songs_path(@artist)
    #   # end 
    # elsif !Song.find_by(id: params[:id]).artist && !Artist.find_by(id: params[:artist_id])
    #   # @song = Song.find(params[:id])
    #   # if !@song.artist
    #   return redirect_to edit_song_path(@song)
    #   # end
    # else# !Artist.find_by(id: params[:artist_id]) && !Song.find_by(id: params[:id])
    #   # binding.pry
    #   @song = Song.find(params[:id])
    #   @artist = @song.artist
    #   return redirect_to artist_song_path(@artist, @song)
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

