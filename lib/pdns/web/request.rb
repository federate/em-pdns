module PDNS
  class Request < Hash
    include Hashie::Extensions::MethodAccess
    include Hashie::Extensions::IndifferentAccess
    include Hashie::Extensions::MergeInitializer
    include Hashie::Extensions::KeyConversion
    include Hashie::Extensions::DeepMerge
    include Hashie::Extensions::Coercion

  	def initialize(args = {})  		
  		super

  		args.each_pair do |k,v|
  			self[k] = v
  		end

  		self.parse!  		
  	end

  	def parse!
  		parts  = self[:path].split('/').map { |p| p.strip }

  		self.merge!({ 
		    :type => parts[0], 	  				 	  			
				:qtype => parts[1],
				:qname => parts[2], 
				:zone_id => parts[3], 
				:remote => parts[5], 
				:local => parts[6], 
				:real_remote => parts[7]
			})
  	end    	

  	def to_json
  		MultiJson.dump(self, :adapter => :yajl, :pretty => true)
  	end

 	end
end