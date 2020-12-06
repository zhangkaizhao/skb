module CustomElementsProcessorHelper

  def process_custom_elements(text : String)
    doc = XML.parse_html(text, options: XMLOptions::HTML_PARSER_OPTIONS)
    doc = CustomElements.process(doc)
    HTML.unescape(doc.to_xml(options: XMLOptions::XML_SAVE_OPTIONS))
  end

end
