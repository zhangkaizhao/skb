module CustomElements

  class RecentlyChangedList

    def self.process(doc)
      content = HTML.unescape(doc.to_xml(options: XMLOptions::XML_SAVE_OPTIONS))
      doc = XML.parse_html(content, options: XMLOptions::HTML_PARSER_OPTIONS)

      doc.xpath_nodes("//recently-changed-list").each do |element|
        limit = (element["limit"]? || "5").to_i
        hstr = XML.build_fragment do |xml|
          xml.element("ul") do
            # XXX Page model should be handled via Dependency Inject
            Page.recently_modified(limit).each do |page|
              xml.element("li") do
                # XXX How to get URI of a page?
                xml.element("a", href: "/#{page.name}") do
                    xml.text page.title
                end
                xml.text " "
                xml.element("span", class: "smaller-font lighten") do
                  xml.text "updated "
                  xml.element("abbr", title: page.modification_time.to_rfc3339) do
                    xml.text page.modification_time.to_rfc2822
                  end
                end
              end
            end
          end
        end

        # XXX escaped HTML. How to append children nodes?
        element.text = hstr.chomp
      end

      doc
    end

  end

end
