class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default

  end

  def index
    #debugger
    @all_ratings = Movie.ratings
    sort = params[:sort_by]
    @ratings_list = params[:ratings]    #stores what checkboxes user has checked
    p params
    p @ratings_list

    if @ratings_list.nil? then #if empty, return empty hash (not nil)
      @ratings_list = @all_ratings 
    elsif @ratings_list.is_a?(Hash) then
      @ratings_list = @ratings_list.keys  
    end  
        
    if sort == "name" then 
      p @ratings_list
      @movies = Movie.find_all_by_rating(@ratings_list, :order => 'title')
      @title_style = 'hilite'
    elsif sort=="date" 
      p @ratings_list
      @movies = Movie.find_all_by_rating(@ratings_list, :order => 'release_date asc')
      @rdate_style = 'hilite'
    else
      @movies = Movie.find(:all, :conditions => {:rating =>  @ratings_list})
    end

  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
