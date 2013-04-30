require 'eventmachine'
require 'pdns/version'
require 'pdns/question'
require 'pdns/pipe'
require 'pdns/backend'

STDOUT.sync = true
STDERR.sync = true

module PDNS

  BANNER = "em-pdns #{VERSION}"

  module ClassMethods
    def run!
      EM.run {
        EM.error_handler { |e|
          STDERR.puts e.message
          STDERR.puts e.backtrace.join("\n")
        }

        trap("TERM") { EM.stop }
        trap("INT") { EM.stop }

        EM.open_keyboard(Pipe)
      }
    end
  end

  extend ClassMethods

end