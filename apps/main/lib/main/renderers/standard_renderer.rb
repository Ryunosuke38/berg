require "redcarpet"
require "rouge"
require "rouge/plugins/redcarpet"

class StandardRenderer < Redcarpet::Render::HTML
  include Redcarpet::Render::SmartyPants
  include Rouge::Plugins::Redcarpet

  # Input syntax:
  # ![](http://example.com/image.jpg|this is some alt text|left|this is the caption)

  def image(link, title = nil, alt_text = nil)
    parse_image_link(link)

    @translated_class =
      if @class == "left"
        'class=figure-align-left'
      elsif @class == "right"
        'class=figure-align-left'
      end

    "<figure #{@translated_class}>
      <img src=\"#{@url}\" alt=\"#{@alt_text}\">
      <figurecaption>#{@caption}</figurecaption>
    </figure>"
  end

  def parse_image_link(link)
    matches = link.match(/^(.*?)\|(.*?)\|(.*?)\|(.*)/)

    @url = matches[1]
    @alt_text = matches[2]
    @class = matches[3]
    @caption = matches[4]
  end
end
