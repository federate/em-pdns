module PDNS
  class Response
    include Hashie::Hash

  	def initialize(args = {})
  		super

    	#new :question => question,
      #    :qname => question.qname,
      #    :qtype => question.qtype
  	end

  	def to_json(options = {})
  		MultiJson.dump(self, options)
  	end

  end
end