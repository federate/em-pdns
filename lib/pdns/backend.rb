module PDNS
  module Backend

  	attr_accessor :logging

  	def logging_enabled?
  		@logging ? true : false
  	end

  	def process(question)
  		answers = []
    	answers << Answer.from_question(question)
    	answers
    end

  end
end