# Include hook code here
require 'social_bookmark'
 
ActionController::Base.send :include, SocialBookmark
ActionController::Base.send :helper, SocialBookmarkHelper