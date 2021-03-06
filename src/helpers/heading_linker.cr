module HeadingLinkerHelper
  def link_headings(text : String)
    doc = XML.parse_html(text, options: XMLOptions::HTML_PARSER_OPTIONS)
    HeadingLinker.new(doc).link_headings!
    HTML.unescape(doc.to_xml(options: XMLOptions::XML_SAVE_OPTIONS))
  end
end
