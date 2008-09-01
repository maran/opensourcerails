class BlogsController < ApplicationController
  # GET /blogs
  # GET /blogs.xml
  def index
    if params[:user_id]
      @blogs = Blog.find_all_by_user_id(params[:user_id])
    else
      @blogs = Blog.find(:all, :order => "created_at DESC")
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @blogs }
    end
  end

  # GET /blogs/1
  # GET /blogs/1.xml
  def show    
    @blog = Blog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.xml  { render :xml => @blog }
    end
  end

  # GET /blogs/new
  # GET /blogs/new.xml
  def new
    @blog = Blog.new  
    @blogs = Blog.find_all_by_user_id(current_user.id)
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @blog }
    end
  end

  # GET /blogs/1/edit
  def edit
    @blog = Blog.find(params[:id])
     return_if_not_welcome
    @blogs = Blog.find_all_by_user_id(current_user.id)
  end

  # POST /blogs
  # POST /blogs.xml
  def create
    @blog = Blog.new(
      params[:blog].merge(
        :user_id => current_user.id        
      )
    )

    respond_to do |format|
      if @blog.save
        flash[:notice] = 'Blog was successfully created.'
        format.html { redirect_to( user_path(current_user.id)) }
        format.xml  { render :xml => @blog, :status => :created, :location => @blog }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @blog.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /blogs/1
  # PUT /blogs/1.xml
  def update
    @blog = Blog.find(params[:id])
    return_if_not_welcome
    
    respond_to do |format|
      if @blog.update_attributes(params[:blog])
        flash[:notice] = 'Blog was successfully updated.'
        format.html { redirect_to(user_path(current_user)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @blog.errors, :status => :unprocessable_entity }
      end
    end
    
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.xml
  def destroy
    @blog = Blog.find(params[:id])
    return_if_not_welcome
    @blog.destroy
    
    respond_to do |format|
      format.html { redirect_to(user_path(current_user)) }
      format.xml  { head :ok }
    end
  end
  
  private
  def verify_owner(blog)
    return true if current_user.id == blog.user_id
    false
  end
  
  def return_if_not_welcome
    return(redirect_to user_path(current_user)) unless verify_owner(@blog)
  end
end
