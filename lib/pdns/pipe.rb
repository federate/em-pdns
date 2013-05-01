module PDNS
  class Pipe < EM::Connection
    include EM::Protocols::LineText2

    attr_accessor :queue, :backend

    def initialize(options = {})
      @queue = self.init_queue 
      @performed_handshake = false  
      @backend = options[:backend] 
    end

    def init_queue
      q = EM::Queue.new

      cb = proc { |line|
        process_line line
        q.pop &cb
      }

      q.pop &cb 

      q
    end

    def process_line(line)      
    	unless performed_handshake?
				perform_handshake(line)			
    	else    		
    		begin
      		q = Question.from_line line
      		answers = @backend.process q
      		send answers.first
      	rescue Exception => e
      		stderr e.message
      		stderr e.backtrace.join("\n")
      		log e.message
      		send "FAIL"
      	end
      end
    end

    def performed_handshake?
			@performed_handshake
    end

    def perform_handshake(line)			
      parts = line.split("\t")

      if parts[0] == 'HELO'
      	send "OK\t#{BANNER}"
      	@performed_handshake = true
      else
				send 'FAIL'
				STDERR.puts "got #{line}"
				@performed_handshake = false
			end
    end

    def post_init			
    	@performed_handshake = false
    end

    def receive_line(line)
    	line.chomp!      
      self.queue.push line
    end

    def send(s)
      stdout s
    end

    def log(s)
      send "LOG\t#{s}"
    end

    def stdout(s)
			STDOUT.puts s
    end

    def stderr(s)
			STDERR.puts s
    end

  end
end