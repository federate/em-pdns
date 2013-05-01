#!/usr/bin/env ruby

require 'bundler/setup'

require File.expand_path('../lib/pdns', __FILE__)

class ExampleBackend
	include PDNS::Backend	
end

eb = ExampleBackend.new

eb.set_answers({:qtype => 'A', :qname_matcher => /.*\.{1}example\.com$/, :domain_name => 'example.com'}) do |question|
		a = PDNS::Answer.from_question question
		a.content = '192.168.1.2' 
		a.ttl = 60
		[a]
	end

PDNS::Web.set :backend, eb

run PDNS::Web 
