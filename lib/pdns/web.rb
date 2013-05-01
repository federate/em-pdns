module PDNS
	class Web < Sinatra::Base
		get %r{/pdns/method/(.+)} do |c|
		  q = Question.from_line(c, '/')
		  answers = settings.backend.process q
		  MultiJson.dump({:result => answers}, :adapter => :yajl, :pretty => true)
		end
	end
end