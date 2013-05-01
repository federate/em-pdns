module PDNS
  class Answer < OpenStruct

  	def initialize(args = {})
  		super args
			#(:type, :qname, :qclass, :qtype, :ttl, :id, :content)
  	end

  	def self.from_question(question)
    	if question.regular_query?
	    	new :question => question,
            :qname => question.qname, 
            :qclass => question.qclass, 
            :qtype => question.qtype,     
            :id => question.id    	           
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

  end
end