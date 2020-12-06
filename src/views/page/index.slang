- content_for "title" do
  == "Pages"

h2 Pages

ul
  - pages.each do |page|
    li
      == link_to page.title, "/#{page.name}"
