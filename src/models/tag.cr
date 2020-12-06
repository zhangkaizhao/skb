class Tag

  class NotFound < Exception; end

  getter name : String
  getter pages : Array(Page)

  def self.all
    # The following code is not working now:
    # mapping = Hash(String, Array(Page)).new(Array(Page).new)
    # ...
    # mapping[tag] << page

    mapping = Hash(String, Array(Page)).new { |hash, key| hash[key] = Array(Page).new }
    Page.all.each do |page|
      page.tags.each { |tag| mapping[tag] << page }
    end

    tags = Array(Tag).new
    mapping.each do |name, pages|
      tags << Tag.new(name, pages)
    end
    tags.sort { |a, b| a.name <=> b.name }
  end

  def self.find(name)
    tag = all.find { |tag| tag.name == name }
    raise NotFound.new("unable to find tag with name #{name.inspect}") if tag.nil?
    tag
  end

  def initialize(name, pages)
    @name = name
    @pages = pages
  end

  def page_count
    pages.size
  end

  def sorted_pages
    pages.sort { |a, b| a.name <=> b.name }
  end

  def last_modified
    pages.map(&.modification_time).sort.last
  end
end
