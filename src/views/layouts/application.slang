doctype html
html
  head
    meta name="viewport" content="initial-scale=1.0"
    meta charset="utf-8"
    title = [yield_content("title"), Amber.settings.skb.name].compact!.join(" - ")
    link rel="stylesheet" href="/application.css"
  body
    header
      a href="/"
        strong.no-margin
          == link_to Amber.settings.skb.name, "/", class: "no-decoration"
      nav.list-flat.list-spaced-left.right
        ul.no-margin
          li
            == link_to "Pages", "/pages"
          li
            == link_to "Tags", "/tags"
      p.lighten.no-margin-top = Amber.settings.skb.tagline

    == content

    footer.smaller-font
      - copyright = Amber.settings.skb.copyright_start_year..Time.utc.year
      p.center-text
        == "Copyright &copy;"
        == [copyright.min, copyright.max].uniq.join(" &ndash; ")
        == link_to Amber.settings.skb.author, Amber.settings.skb.author_url
        br
        span.smaller-font.center-text Powered by
          == link_to "skb", "https://github.com/zhangkaizhao/skb"
