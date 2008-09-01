class ComposController < ApplicationController
  def index
    @compos = Compo.find(:all)
  end
  
  def show
    @compo = Compo.find(params[:id])
    @tag =  Tag.find_by_name(@compo.tag)
    if @tag
      @projects = @tag.taggings.map{|t| t.taggable if t.taggable.is_a? Project}
    end
  end
  
  def new
    @compo = Compo.new
  end
  
  def create
    @compo = Compo.new(params[:compo])
    if @compo.save
      flash[:notice] = "Competition saved."
      redirect_to compos_path
    else
      flash[:error] = "Competition could not be saved."
      render :action => "new"
    end
  end
end