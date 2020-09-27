class PageController < ApplicationController

  def index
    pages = Page.all.sort { |a, b| a.name <=> b.name }
    render1 "index.slang"
  end

  def show
    unless page_params.valid?
      halt!(400, "invalid page name")
    end

    page_name = params[:id]? || "home"
    begin
      page = Page.new(page_name)
    rescue Page::NotFound
      halt!(404, "Not Found")
    else
      render1 "show.slang"
    end
  end

  private def page_params
    params.validation do
      optional(:id, "invalid page") { |p| p.matches?(/^[a-z0-9-]*$/) }
    end
  end

end
