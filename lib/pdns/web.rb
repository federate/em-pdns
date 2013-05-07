module PDNS
	class Web < Sinatra::Base
		get %r{/pdns/method/(.+)} do |c|
			parts = line.split('/').map { |p| p.strip }

		  request = Request.new(:type => parts[0], 	  				 	  			
									  				:qtype => parts[1],
									  				:qname => parts[2], 
									  				:zone_id => parts[3], 
									  				:remote => parts[5], 
									  				:local => parts[6], 
									  				:real_remote => parts[7])

		  response = settings.backend.process request
		  MultiJson.dump({:result => answers}, :adapter => :yajl, :pretty => true)
		end
	end
end