# skb - Simple knowledge base

skb is a small [Crystal]/[Amber] application that allows you to simply publish a collection of Markdown files.

This is inspired by [pkb]. And most of the source code is ported from [pkb].

The purpose of skb is just a practice of the Crystal language.

The favicon (pencil-alt) is from [Heroicons]

## Building

* [Install Crystal]
* Run `shards build` then get the built binary `bin/skb`

## Configuration

* Copy the `settings.default.yml` file to `settings.yml` and fill in your own details
* Replace any static files in the `public` directory. e.g. `favicon.ico`
* Link the directory with your Markdown files in it. e.g. `ln -s ~/Dropbox/My\ Markdown\ Files pages`
* Start the server, `./bin/skb` and visit http://localhost:3000/pages
* You should have Markdown file called `home.md`. This file will be shown as the homepage: http://localhost:3000/

[Crystal]: https://crystal-lang.org/
[Amber]: https://amberframework.org/
[pkb]: https://github.com/wezm/pkb
[Heroicons]: https://github.com/tailwindlabs/heroicons
[Install Crystal]: https://crystal-lang.org/install/
