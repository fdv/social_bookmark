# Install hook code here
puts "** Installing Social Bookmarks Plugin...." 

config = File.join(RAILS_ROOT, '/vendor/plugins/social_bookmark/lib/sites_EN.xml')
dest = File.join(RAILS_ROOT, '/config/sites_EN.xml')
puts "** Copying config file into #{dest} ...." 
FileUtils.cp(config, dest) unless File.exists? dest

images = File.join(RAILS_ROOT, '/vendor/plugins/social_bookmark/images/')
dest = File.join(RAILS_ROOT, '/public/images/social_bookmark/')

unless File.exists? dest
  FileUtils.cd images
  FileUtils.mkdir dest
  FileUtils.cp_r Dir.glob('*.png'), dest, :noop => true, :verbose => true  
end

puts "** Installation finished, edit your configuration file to select your bookmark list and restart your application afterwards ...." 
