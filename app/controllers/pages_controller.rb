class PagesController < ApplicationController

  layout "admin"

  before_action :confirm_logged_in
  before_action :find_subject
  before_action :find_params, only: [:show, :edit, :update, :delete]
  
  def index
    #@pages = Page.where(:subject_id => @subject.id).sorted
    @pages = @subject.pages.sorted
  end

  def show
  end

  def new
    @page = Page.new({:subject_id => @subject.id, :name => "Default"})
    @subjects = Subject.order('position ASC')
    @page_count = Page.count + 1
  end

  def create
    # Instantiate a new object using form parameters
    @page = Page.new(page_params)
    # Save the object, If save succeeds, redirect to the index aciton ## add flash hash
    if @page.save
      flash[:notice] = "Page created successfully"
      redirect_to action: "index", :subject_id => @subject.id
    else      
    # else If save fails, redisplay the form so user can fix problems 
      @subjects = Subject.order('position ASC')
      @page_count = Page.count + 1
      render 'new'
    end    
  end

  def edit
    @subjects = Subject.order('position ASC')
    @page_count = Page.count 
  end

  def update
    # Find an existing object using form parameters or use before action above
        
    # Update the object, If update succeeds, redirect to the show aciton    ## Add flash hash
    if @page.update_attributes(page_params)
      flash[:notice] = "Page updated successfully"
      redirect_to action: "show", :id => @page.id, :subject_id => @subject.id
    else
      # If save fails, redisplay the form so user can fix problems
      @subjects = Subject.order('position ASC')
      @page_count = Page.count 
      render 'edit'
    end  
  end

  def delete    
  end

  def destroy
    page = Page.find(params[:id]).destroy
    flash[:notice] = "Page '#{page.name}' destroyed successfully"
    redirect_to(:action => 'index', :subject_id => @subject.id)       
  end

  private

  def find_params
    @page = Page.find(params[:id])    
  end

  def page_params
    params.require(:page).permit(:subject_id, :name, :permalink, :position, :visible, :created_at)
  end

  def find_subject
    if params[:subject_id]
      @subject = Subject.find(params[:subject_id])
    end
  end
end
