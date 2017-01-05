Jekyll::Hooks.register :site, :pre_render do |site|
	indecesByNames = Hash.new
	i = Integer(0)
	site.collections['people'].docs.each do |person|
		if person['pub-names']
			person['pub-names'].each do |pubName|
				indecesByNames[pubName] = i
			end
		end
		i = i + 1
	end
	site.data['indecesByNames'] = indecesByNames
end
