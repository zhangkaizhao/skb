- content_for "title" do
  == page.title

article
  h1
    == link_to page.title, "/#{page.name}", class: "no-decoration"

  == page.to_html

  div.smaller-font.lighten.shaded-panel
    p Last modified at:
      == content :abbr, page.modification_time.to_rfc2822, options: { :title => page.modification_time.to_rfc3339 }
    ul.list-flat.list-spaced-right
      - page.tags.each do |tag|
        li
          == link_to "##{tag}", "/tags/#{tag}"
