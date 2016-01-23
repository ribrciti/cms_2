class SubjectsController < ApplicationController

  layout "admin"

  before_action :confirm_logged_in
  before_action :find_params, only: [:show, :edit, :update, :delete]  
  
  def index
    @subjects = Subject.sorted    # sorted is lambda from model
  end

  def show
  end

  def new
    @subject = Subject.new({:name => "Default"})
    @subject_count = Subject.count + 1
  end

  def create
    # Instantiate a new object using form parameters
    @subject = Subject.new(subject_params)
    # Save the object
    if @subject.save
      # If save succeeds, redirect to the index aciton ## add flash hash
      flash[:notice] = "Subject created successfully"
      redirect_to(:action => 'index')
     else
      # If save fails, redisplay the form so user can fix problems
      @subject_count = Subject.count + 1
      render('new')
    end
  end
  
  def edit
     #before action above
     @subject_count = Subject.count
  end

  def update
    # Find an existing object using form parameters
        #before action above
    # Update the object
    if @subject.update_attributes(subject_params)
      # If update succeeds, redirect to the show aciton, needs @var.id too  ## Add flash hash
      flash[:notice] = "Subject created successfully"
      redirect_to(:action => 'show',:id => @subject.id)
     else
      # If save fails, redisplay the form so user can fix problems
       @subject_count = Subject.count
      render('edit')
    end
  end

  def delete
  end

  def destroy
    subject = Subject.find(params[:id]).destroy
    ## Add flash   hash
    flash[:notice] = "Subject '#{subject.name}' destroyed successfully"
    redirect_to(:action => 'index')   
  end



  private

  def subject_params
    params.require(:subject).permit(:name, :position, :visible, :created_at)
  end

  def find_params
    @subject = Subject.find(params[:id])
  end
end
