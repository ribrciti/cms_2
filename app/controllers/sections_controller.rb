class SectionsController < ApplicationController

  layout "admin"

  before_action :find_params, only: [:show, :edit, :update, :delete]
  
  def index
    @sections = Section.sorted
  end

  def show
  end

  def new
    @section = Section.new
    @pages = Page.order('position ASC')
    @section_count = Section.count + 1
  end

  def create
    # Instantiate a new object using form parameters
    @section = Section.new(section_params)
    # Save the object, If save succeeds, redirect to the index aciton ## add flash hash
    if @section.save
      flash[:notice] = "Subject created successfully"
      redirect_to action: "index"
    else      
      # else If save fails, redisplay the form so user can fix problems
      @pages = Page.order('position ASC')
      @section_count = Section.count + 1
      render 'new'
    end     
  end

  def edit
    @pages = Page.order('position ASC')
    @section_count = Section.count
  end

  def update
    # Find an existing object using form parameters or use before action above
    
    # Update the object, If update succeeds, redirect to the show aciton    ## Add flash hash
    if @section.update_attributes(section_params)
      flash[:notice] = "Subject updated successfully"
      redirect_to action: "show", :id => @section.id
    else
      # If save fails, redisplay the form so user can fix problems
      @pages = Page.order('position ASC')
      @section_count = Section.count
      render 'edit'
    end  
  end

  def delete    
  end

  def destroy
    section = Section.find(params[:id]).destroy
    flash[:notice] = "Section '#{section.name}' destroyed successfully"
    redirect_to(:action => 'index')       
  end

  private

  def find_params
    @section = Section.find(params[:id])    
  end

  def section_params
    params.require(:section).permit(:page_id, :name, :position, :visible, 
      :content_type, :content, :created_at)
  end
end