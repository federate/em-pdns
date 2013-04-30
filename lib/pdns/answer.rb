module PDNS
  class Answer < Struct.new(:type, :qname, :qclass, :qtype, :ttl, :id, :content)

    def to_s
      "#{self.type}\t#{self.qname}\t#{self.qclass}\t#{self.qtype}\t#{self.ttyl}\t#{self.id}\t#{self.content}"
    end

  end
end