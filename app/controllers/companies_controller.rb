class CompaniesController < ApplicationController

  before_filter :check_administrator_role

  def index
    @companies = Company.find(:all)
  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
  end

  def edit
    @company = Company.find(params[:id])
  end

  def create
    @company = Company.new(params[:company])

    if @company.save
      flash[:notice] = 'La société a bien été créée'
      redirect_to(companies_url)
    else
      render :action => "new"
    end
  end

  def update
    @company = Company.find(params[:id])

    if @company.update_attributes(params[:company])
      flash[:notice] = 'La société a bien été modifiée'
      redirect_to(@company)
    else
      render :action => "edit"
    end
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy
    redirect_to(companies_url)
  end

end
