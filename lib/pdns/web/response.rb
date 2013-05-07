module PDNS
  class Response < OpenStruct

  	def initialize(args = {})
  		super args			

    	#new :question => question,
      #    :qname => question.qname,             
      #    :qtype => question.qtype   
  	end  

  end  
end  