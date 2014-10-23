class BlogsController < ApplicationController
  before_action :logged_in_user

  def new
    @blog = current_user.blogs.build
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    if @blog.save
      flash[:success] = "New Blog created!"
      redirect_to root_url
    elsif
      render root_url
    end

  end

  def destroy

  end

  def update

  end

  def edit

  end

  private
    def blog_params
      params.require(:blog).permit(:content)
    end

end
