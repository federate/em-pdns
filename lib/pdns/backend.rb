module PDNS
  module Backend

  	attr_accessor :logging

  	def logging_enabled?
  		@logging ? true : false
  	end

  	def answer_map
  		@answer_map ||= {}
  	end

  	def process(question)
  		answers = []
  		
  		qname = question.qname
  		qtype = question.qtype
  		domain_name = qname.scan(/[^\.]+\.{1}[^\.]+$/).first

  		puts self.answer_map.inspect
  		puts qname.inspect
  		puts qtype.inspect
  		puts domain_name.inspect

    	return answers if qname.nil? || qtype.nil? || domain_name.nil?
    	return answers unless self.answer_map[domain_name] && self.answer_map[domain_name][qtype]

    	haystack = self.answer_map[domain_name][qtype]
    	puts haystack.inspect
    	needle = haystack.find { |h| h[:qname_matcher] =~ qname }

    	puts needle.inspect

    	return answers unless needle

    	answers += needle[:answer_block].call(question)    		

    	puts answers.inspect

    	answers
    end

    def set_answers(options = {}, &blk)
    	domain_name = options[:domain_name]
    	qtype = options[:qtype]    	
    	qname_matcher = options[:qname_matcher]

    	unless self.answer_map[domain_name]
    		self.answer_map[domain_name] = {qtype => []}
    	end

    	unless self.answer_map[domain_name][qtype]
				self.answer_map[domain_name][qtype] = []
    	end
			
			self.answer_map[domain_name][qtype] ||= []
			self.answer_map[domain_name][qtype] << {:qname_matcher => qname_matcher, :answer_block => blk}	  
    end    

  end
end