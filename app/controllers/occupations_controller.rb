class OccupationsController < ApplicationController

  def index
    @occupations = Occupation.find(:all)
  end

  def show
    @occupation = Occupation.find(params[:id])
  end

  def new
    @occupation = Occupation.new
  end

  def edit
    @occupation = Occupation.find(params[:id])
  end

  def create
    @occupation = Occupation.new(params[:occupation])
    if @occupation.save
      flash[:notice] = 'Le métier a été bien été créé'
      redirect_to(@occupation)
    else
      render :action => "new"
    end
  end

  def update
    @occupation = Occupation.find(params[:id])
    if @occupation.update_attributes(params[:occupation])
      flash[:notice] = 'Le métier a bien été modifié'
      redirect_to(@occupation)
    else
      render :action => "edit"
    end
  end

  def destroy
    @occupation = Occupation.find(params[:id])
    @occupation.destroy
    redirect_to(occupations_url)
  end
end
