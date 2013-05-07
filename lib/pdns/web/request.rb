module PDNS
  class Request < OpenStruct

  	def initialize(path, params = {})  		
  		parts = path.split('/').map { |p| p.strip }
  		super { 
  			      :type => parts[0], 	  				 	  			
							:qtype => parts[1],
							:qname => parts[2], 
							:zone_id => parts[3], 
							:remote => parts[5], 
							:local => parts[6], 
							:real_remote => parts[7]
						}
  	end    	

 	end
end