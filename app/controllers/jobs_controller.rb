class JobsController < ApplicationController
  layout 'application'
  
  before_filter :check_administrator_role
  before_filter :find_company
  
  def index
    @jobs = @company.jobs.sort_by { |job| job.occupation.title }
  end

  def show
    @job = Job.find(params[:id])
  end

  def new
    @job = Job.new(:company_id => @company.id)
  end

  def edit
    @job = Job.find(params[:id])
  end

  def create
    @job = Job.new(params[:job])
    if @job.save
      flash[:notice] = 'Le poste a bien été créé'
      redirect_to company_job_path(@company, @job)
    else
      render :action => "new"
    end
  end

  def update
    @job = Job.find(params[:id])
    if @job.update_attributes(params[:job])
      flash[:notice] = 'Le poste a bien été modifié'
      redirect_to company_job_path(@company, @job)
    else
      render :action => "edit"
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to(company_jobs_url(@company))
  end

protected
  def find_company
    @company = Company.find(params[:company_id])
  end
end
