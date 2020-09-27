- content_for "title" do
  == "Tag: #{tag.name}"

h1 = tag.name

ul
  - tag.sorted_pages.each do |page|
    li
      == link_to page.title, "/#{page.name}"
