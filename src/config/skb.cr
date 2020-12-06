require "yaml"

module Amber::Environment
  class Settings
    class Skb
      include YAML::Serializable

      property author : String = "Some One"
      property author_url : String = "http://example.com/"
      property copyright_start_year : Int32 = 2020
      property name : String = "Site Name"
      property domain : String = "example.com"
      property tagline : String = "A short tagline"
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
