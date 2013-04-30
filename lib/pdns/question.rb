module PDNS
  class Question < Struct.new(:type, :qname, :qclass, :qtype, :id, :remote_ip_address, :local_ip_address, :edns_subnet_address)

    def to_answer
      case self.type
      when 'HELO'
        "OK\t#{BANNER}"
      else
        "FAIL"
      end
    end

  end
end