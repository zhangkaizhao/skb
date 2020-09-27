- content_for "title" do
  == "Tags"

h2 Tags

ul
  - tags.each do |tag|
    li
      == link_to tag.name, "/tags/#{tag.name}"
      span.badge.lighten.monospace = tag.page_count
