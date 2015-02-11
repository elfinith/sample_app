module ApplicationHelper

	#Returns the full title on a peer-page basis.
	def full_title(page_title)
		base_title = "Хуитор"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

        #Autofocus
        def set_focus_to_id(id)
        	javascript_tag("$('#{id}').focus()")
        end
end
