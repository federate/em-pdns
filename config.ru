#!/usr/bin/env ruby

require 'bundler/setup'

require File.expand_path('../lib/pdns', __FILE__)

class ExampleBackend
	include PDNS::Backend
end

eb = ExampleBackend.new

finder = lambda { |question|
  a = PDNS::Answer.from_question question
  a.content = '192.168.1.2'
  a.ttl = 60
  [a.to_result]
}

stack = PDNS::Stack.new {
  use HostGuardMiddleware, :account_manager => account_manager
  use MessagePreprocessorMiddleware
  use MessageGuardMiddleware
  use InboundEndPointGroupMiddleware, :account_manager => account_manager
}


eb.set_answers({:qtype => 'A', :qname_matcher => Regexp.new(".*\.{0,1}example\.com$"), :domain_name => 'example.com'}, &finder)

PDNS::Web.set :backend, eb

run PDNS::Web
