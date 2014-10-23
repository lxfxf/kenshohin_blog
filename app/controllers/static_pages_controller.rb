class StaticPagesController < ApplicationController
  def home
    @blogs_all = Blog.all

    @blogs = Blog.paginate(page: params[:page])

  end
end
