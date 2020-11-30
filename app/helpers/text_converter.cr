module TextConverterHelper
  def markdown_to_html(text : String)
    Markd.to_html(text)
  end
end
