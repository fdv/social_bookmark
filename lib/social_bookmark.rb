# SocialBookmark
module SocialBookmark
  require 'rexml/document'

  def parse_config(permalink, title)
    xml = REXML::Document.new(File.open("#{RAILS_ROOT}/config/sites_EN.xml"))

    output << "<p id='social'>"

    REXML::XPath.each(xml, "social_sites/site/") do |elem|
      bookmark = REXML::XPath.match(elem, "name/text()").first.value
      url = REXML::XPath.match(elem, "url/text()").first.value.gsub('{link}', permalink).gsub('{title}', CGI::escape(title))
      image = REXML::XPath.match(elem, "img/text()").first.value

      output << "<span>"
      output << "<img src='/images/social_bookmark/#{image}' alt='Add to #{bookmark}' /> "
      output << "<a href='#{url}'>#{bookmark}</a>"
      output << "</span> "
    end
    
    output << "</p>"
    
    return output
  end
  
end

module SocialBookmarkHelper
  def render_social_bookmarks(permalink, title)
    @controller.parse_config(permalink, title)
  end
end