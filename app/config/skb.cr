require "yaml"

module Amber::Environment
  class Settings
    class Skb
      YAML.mapping(
        author: {
          type: String,
          default: "Some One",
        },
        author_url: {
          type: String,
          default: "http://example.com/",
        },
        copyright_start_year: {
          type: Int32,
          default: 2020,
        },
        name: {
          type: String,
          default: "Site Name",
        },
        domain: {
          type: String,
          default: "example.com",
        },
        tagline: {
          type: String,
          default: "A short tagline",
        },
      )
    end

    property skb : Skb?

    def skb
      @skb ||= begin
        content = ""
        content += File.read("./settings.yml") if File.exists?("./settings.yml")
        Skb.from_yaml(content)
      end

    end
  end
end
