module ApplicationHelper

	def urls_to_images(s)
		s.gsub! /\s(https:\/\/.*?\.(png|JPG))(\s|\Z)/,
				'<p><img src="\1"/></p>'	
		s.html_safe		
	end

	def urls_to_links(s)
		s.gsub! /\s(https:\/\/.*?)(\s|\Z)/,
				'<a href="\1">\1</a>'	
		s.html_safe		
	end

end
