module Jekyll
  module Filters
    def byte_to_mb(input)
      (input.to_f / 1024 / 1024).round(1)
    end
  end

  class ExtLinkTag < Liquid::Tag
    @text = ''
    @link = ''

    def initialize(tag_name, markup, tokens)
      if markup =~ /(.+)(\s+(https?:\S+))/i
        @text = $1
        @link = $3
      end
      super
    end

    def render(context)
      output = super
      "<a class='external' target='_blank' href='#{@link}'>#{@text}</a>"
    end
  end
end

Liquid::Template.register_tag('extlink', Jekyll::ExtLinkTag)
