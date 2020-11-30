module HeadingLinkerHelper
  def link_headings(text : String)
    doc = XML.parse_html(text, options: HeadingLinker::HTML_PARSER_OPTIONS)
    HeadingLinker.new(doc).link_headings!
    HTML.unescape(doc.to_xml(options: HeadingLinker::XML_SAVE_OPTIONS))
  end
end
