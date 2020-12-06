require "sitemapper"

Sitemapper.configure do |c|
  c.host = Amber.settings.skb.domain
  c.sitemap_host = Amber.settings.skb.domain
  c.compress = false
end
