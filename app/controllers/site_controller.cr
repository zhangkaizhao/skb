class SiteController < ApplicationController

  def sitemap
    home = Page.home
    pages = Page.all
    tags = Tag.all

    sitemaps = Sitemapper.build do
      add(
        "/",
        lastmod: home.modification_time,
        changefreq: "weekly",
        priority: 0.9
      )

      add(
        "/pages",
        lastmod: pages.map(&.modification_time).max,
        changefreq: "weekly",
        priority: 0.9
      )

      add(
        "/tags",
        lastmod: tags.map(&.last_modified).max,
        changefreq: "weekly",
        priority: 0.6
      )

      pages.each do |page|
        add(
          "/#{page.name}",
          lastmod: page.modification_time,
          changefreq: "weekly",
          priority: 1.0
        )
      end

      tags.each do |tag|
        add(
          "/tags/#{tag.name}",
          lastmod: tag.last_modified,
          changefreq: "weekly",
          priority: 0.4
        )
      end
    end

    respond_with do
      xml sitemaps.first["data"]
    end
  end

end
