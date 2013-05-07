module PDNS
  class Answer < Hash
    include Hashie::Extensions::MethodAccess
    include Hashie::Extensions::IndifferentAccess
    include Hashie::Extensions::MergeInitializer
    include Hashie::Extensions::KeyConversion
    include Hashie::Extensions::DeepMerge
    include Hashie::Extensions::Coercion

    coerce_value Hash, Answer

  	def initialize(h = {})
  		super

      h.each_pair do |k,v|
      	self[k] = v
      end
  	end

  	def self.from_question(question)
    	if question.regular_query?
	    	new :question => question,
            :qname => question.qname, 
            :qclass => question.qclass, 
            :qtype => question.qtype,     
            :id => question.id              
      elsif question.lookup_query?
	    	new :question => question,
            :qname => question.qname,
            :qtype => question.qtype
	   	elsif question.list_request?
				new :question => question,
						:id => question.id
	   	elsif question.ping_request?
				new :question => question
	   	else
	   		raise PDNSError, 'not a valid question'
	   	end
    end

    def to_s
      "#{self.type}\t#{self.qname}\t#{self.qclass}\t#{self.qtype}\t#{self.ttl}\t#{self.id}\t#{self.content}"
    end

    def to_json
    	MultiJson.dump(self, :adapter => :yajl, :pretty => true)
    end

    def to_result
      self.select { |k,v| k.to_sym != :question }
    end

  end
end