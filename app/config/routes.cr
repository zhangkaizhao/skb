Amber::Server.configure do |app|
  pipeline :static do
    plug Amber::Pipe::PoweredByAmber.new
    plug Amber::Pipe::Error.new
    plug Amber::Pipe::Static.new("./public")
  end

  routes :static do
    get "/application.css", Amber::Controller::Static, :index
    get "/favicon.ico", Amber::Controller::Static, :index
  end

  pipeline :web do
  end

  routes :web do
    get "/", PageController, :show

    resources "/pages", PageController, only: [:index, :show]
    resources "/tags", TagController, only: [:index, :show]

    get "/sitemap(.xml)", SiteController, :sitemap

    get "/:id", PageController, :show
  end
end
