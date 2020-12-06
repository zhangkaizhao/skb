class TagController < ApplicationController

  def index
    tags = Tag.all
    render1 "index.slang"
  end

  def show
    begin
      tag = Tag.find(params[:id])
    rescue Tag::NotFound
      halt!(404, "Not Found")
    else
      render1 "show.slang"
    end
  end

end
