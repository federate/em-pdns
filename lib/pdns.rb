require 'hashie'
require 'sinatra/base'
require 'thin'
require 'multi_json'
require 'yajl'
require 'pdns/version'
require 'pdns/exceptions'
require 'pdns/stack'
require 'pdns/middleware'
require 'pdns/backend'
require 'pdns/web/request'
require 'pdns/web/response'
require 'pdns/web'
require 'pdns/pipe/answer'
require 'pdns/pipe/question'
require 'pdns/pipe'

STDOUT.sync = true
STDERR.sync = true

module PDNS

  BANNER = "em-pdns #{VERSION}"

  module ClassMethods
    def run!(options = {})
    	backend = options[:backend]

      EM.run {
        EM.error_handler { |e|
          STDERR.puts e.message
          STDERR.puts e.backtrace.join("\n")
        }

        trap("TERM") { EM.stop }
        trap("INT") { EM.stop }

        EM.open_keyboard(Pipe, :backend => backend)
      }

    end
  end

  extend ClassMethods

end