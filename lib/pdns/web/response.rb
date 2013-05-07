module PDNS
  class Response < Hash
    include Hashie::Extensions::MethodAccess
    include Hashie::Extensions::IndifferentAccess
    include Hashie::Extensions::MergeInitializer
    include Hashie::Extensions::KeyConversion
    include Hashie::Extensions::DeepMerge
    include Hashie::Extensions::Coercion

  	def initialize(args = {})
  		super args			

    	#new :question => question,
      #    :qname => question.qname,             
      #    :qtype => question.qtype   
  	end  

  	def to_json
  		MultiJson.dump(self, :adapter => :yajl, :pretty => true)
  	end

  end  
end  