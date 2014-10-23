class BlogsController < ApplicationController
  before_action :logged_in_user

  def new
    @blog = current_user.blogs.build
  end

  def create
    @blog = current_user.blogs.build(blog_params)

    if @blog.save
      @image = @blog.images.build(image_params)
      if params[:images]
        params[:images].each { |image|
          @blog.images.create(image: image)
        }
      end
      redirect_to root_url
    elsif
      render write_path
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

    def image_params
      params.require(:blog).permit(:image)
    end
end
