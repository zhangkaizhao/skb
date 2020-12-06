module Amber::Controller::Helpers
  module Render

    macro render1(template = nil, layout = true, partial = nil, folder = __FILE__)
      # TODO calculate `__content_filename__` as a local variable for `yield_content` macro
      # __content_filename__ = {{template || partial}}
      render({{template}}, {{layout}}, {{partial}}, "src/views", {{folder}})
    end

  end
end
