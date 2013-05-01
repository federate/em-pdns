require 'hashie'
require 'sinatra/base'
require 'thin'
require 'multi_json'
require 'yajl'
require 'pdns/version'
require 'pdns/exceptions'
require 'pdns/answer'
require 'pdns/question'
require 'pdns/pipe'
require 'pdns/backend'
require 'pdns/web'

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