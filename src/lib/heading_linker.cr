require "html"
require "uri"
require "xml"

class HeadingLinker

  property doc : XML::Node

  def initialize(@doc)
  end

  def link_headings!
    add_anchors_to_headers!
    # XXX escaped HTML. How to append children nodes?
    content = HTML.unescape(doc.to_xml(options: XMLOptions::XML_SAVE_OPTIONS))
    doc = XML.parse_html(content, options: XMLOptions::HTML_PARSER_OPTIONS)
  end

  private def add_anchors_to_headers!
    doc.xpath_nodes("//h1 | //h2 | //h3 | //h4 | //h5 | //h6").each do |heading|
      identifier = URI.encode_path(heading.text)

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
