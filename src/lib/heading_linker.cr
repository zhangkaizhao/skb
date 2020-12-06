require "html"
require "uri"
require "xml"

class HeadingLinker
  HTML_PARSER_OPTIONS = XML::HTMLParserOptions.default | XML::HTMLParserOptions::NODEFDTD
  XML_SAVE_OPTIONS = XML::SaveOptions::FORMAT | XML::SaveOptions::AS_HTML

  property doc : XML::Node

  def initialize(@doc)
  end

  def link_headings!
    add_anchors_to_headers!
    # XXX escaped HTML. How to append children nodes?
    content = HTML.unescape(doc.to_xml(options: XML_SAVE_OPTIONS))
    doc = XML.parse_html(content, options: HTML_PARSER_OPTIONS)
  end

  private def add_anchors_to_headers!
    doc.xpath_nodes("//h1 | //h2 | //h3 | //h4 | //h5 | //h6").each do |heading|
      identifier = URI.encode(heading.text)

      hstr = XML.build_fragment do |xml|
          xml.element("a", id: identifier, class: "anchor", href: "##{identifier}") do
            xml.element("span", class: "link-icon monospace") do
              xml.text "#"
            end
          end
          xml.text heading.text
      end

      # XXX escaped HTML. How to append children nodes?
      heading.text = hstr.chomp
    end
  end
end
