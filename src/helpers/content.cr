module JasperHelpers::Tags

  def content(element_name : Symbol, content : String)
    options = OptionHash.new
    content(element_name: element_name, options: options) do
      content
    end
  end

end
