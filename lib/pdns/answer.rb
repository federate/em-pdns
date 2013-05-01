module PDNS
  class Answer < OpenStruct

  	def initialize(args = {})
  		super args			
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
    	h = self.marshal_dump
    	h.delete(:question)
    	MultiJson.dump(h, :adapter => :yajl, :pretty => true)
    end

  end
end