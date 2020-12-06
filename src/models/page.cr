require "yaml"

require "markd"

class Page

  class NotFound < Exception; end

  class Metadata
    include YAML::Serializable

    property title : String?
    property tags : Array(String)?
    property hidden : Bool?
  end

  YAML_BOUNDARY = "---"

  getter name : String
  getter path : Path

  # @metadata : Hash(YAML::Any, YAML::Any) | Nil
  @metadata : Metadata | Nil
  @content : String | Nil
  @markdown : String | Nil

  def self.page_files_in(basepath)
    Dir.new(basepath)
      .children
      .select { |filename| File.match?("*.md", filename) }
  end

  def self.all(basepath = Path.new("./pages"))
    page_files_in(basepath)
      .map { |filename| new(File.basename(filename, ".md"), basepath) }
      .reject { |page| page.empty? || page.hidden? }
  end

  def self.home
    new "home"
  end

  def self.last_modified(basepath = Path.new("./pages"))
    page_files_in(basepath).map(&:modification_time).sort.last
  end

  def self.recently_modified(limit=10, basepath=Path.new("./pages"))
    all
      .sort { |a, b| b.modification_time <=> a.modification_time }
      .first(limit)
  end

  def initialize(name, basepath = Path.new("./pages"))
    @name = name.to_s
    @path = basepath.join("#{name}.md")
    raise NotFound.new("unable to find page with name #{name.inspect}") unless File.exists?(@path)
  end

  def modification_time
    File.new(path).info.modification_time
  end

  def title
    # metadata.fetch("title", name).as(String)
    metadata.try &.title || name
  end

  def tags
    # metadata.fetch("tags", [] of YAML::Any).as(Array(YAML::Any))
    metadata.tags || Array(String).new
  end

  def hidden?
    # metadata.fetch("hidden", false).as(Bool)
    metadata.try &.hidden || false
  end

  def empty?
    File.new(path).info.size.zero?
  end

  def markdown
    @markdown ||= begin
                    if content.lines.first.rstrip == YAML_BOUNDARY
                      _, _, markdown = content.split(YAML_BOUNDARY, 3)
                    else
                      markdown = content
                    end
                    markdown
                  end
  end

  private def content
    @content ||= File.read(path)
  end

  private def metadata
    @metadata ||= if content.lines.first.rstrip == YAML_BOUNDARY
                    # YAML.parse(content).as_h
                    Metadata.from_yaml(content)
                  else
                    # {} of YAML::Any => YAML::Any
                    Metadata.from_yaml("")
                  end
  end
end
