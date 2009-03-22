# SocialBookmark
module SocialBookmark
  require 'rexml/document'
  
  class SocialItem < Struct.new(:url, :name, :image)
    def to_s; title end
  end

  def parse_config(permalink, title)
    xml = REXML::Document.new(File.open("#{RAILS_ROOT}/config/sites_EN.xml"))
    items = []

    REXML::XPath.each(xml, "social_sites/site/") do |elem|
      item        = SocialItem.new
      item.name   = REXML::XPath.match(elem, "name/text()").first.value rescue ""
      item.url    = REXML::XPath.match(elem, "url/text()").first.value.gsub('{link}', 
                    permalink).gsub('{title}', CGI::escape(title)) rescue ""
      item.image  = REXML::XPath.match(elem, "img/text()").first.value rescue ""
      
      items << item
    end
    
    items.sort_by { |item| item.name }
  end
end

module SocialBookmarkHelper
  def render_social_bookmarks(permalink, title)
    items = @controller.parse_config(permalink, title)
    
    output = "<p id='social'>"
    
    items.each do |item|
      output << "<span>"
      output << "<a href='#{item.url}'>"
      output << "<img src='/images/social_bookmark/#{item.image}' alt='Add to #{item.name}' /> "
      output << "#{item.name}"
      output << "</a>"
      output << "</span> "
    end

    output << "</p>"
  end
end