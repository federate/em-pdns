module PDNS
	class Web < Sinatra::Base

		get %r{/pdns/method/(.+)} do |path|		
		  request = Request.new(:path => path, :params => params)

		  response = settings.backend.process request
		  MultiJson.dump({:result => answers}, :adapter => :yajl, :pretty => true)
		end

	end
end