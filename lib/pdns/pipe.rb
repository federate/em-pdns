module PDNS
  class Pipe < EM::Connection
    include EM::Protocols::LineText2

    def post_init

    end

    def receive_line(line)
      line.chomp!
      parts = line.split("\t")
      q = Question.new *parts
      send q.to_answer
    end

    def send(s)
      STDOUT.puts s
    end

    def log(s)
      send "LOG\t#{s}"
    end

  end
end