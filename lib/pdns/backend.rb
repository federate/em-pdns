module PDNS
  module Backend

<<<<<<< HEAD
    def answer(opts = {})
      Answer.new
=======
  	attr_accessor :logging

  	def logging_enabled?
  		@logging ? true : false
  	end

  	def answer_map
  		@answer_map ||= Hashie::Mash.new
  	end

  	def process(question)
  		answers = []

  		qname = question.qname
  		qtype = question.qtype
  		domain_name = qname.scan(/[^\.]+\.{1}[^\.]+$/).first

    	return answers if qname.nil? || qtype.nil? || domain_name.nil?
    	return answers unless self.answer_map[domain_name] && self.answer_map[domain_name][qtype]

    	haystack = self.answer_map[domain_name][qtype]
    	needle = haystack.find { |h| h[:qname_matcher] =~ qname }

      puts haystack.inspect
      puts needle.inspect

    	return answers unless needle

    	answers += needle[:answer_block].call(question)

    	answers
>>>>>>> 779dfb0d4ef7d1a63075ec3213b288718509aff8
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