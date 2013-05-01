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

  	def process(question)
  		answers = []
    	answers << Answer.from_question(question)
    	answers
>>>>>>> 779dfb0d4ef7d1a63075ec3213b288718509aff8
    end

  end
end