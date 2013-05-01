module PDNS
  class Question < Hash
    include Hashie::Extensions::MethodAccess
    include Hashie::Extensions::IndifferentAccess
    include Hashie::Extensions::MergeInitializer
    include Hashie::Extensions::KeyConversion
    include Hashie::Extensions::DeepMerge
    include Hashie::Extensions::Coercion

    coerce_value Hash, Question

  	def initialize(h = {})
  		super

      h.each_pair do |k,v|
       self[k] = v
      end
  	end

  	def self.from_line(line, delimiter = "\t")
  		parts = line.split(delimiter).map { |p| p.strip }

  		case parts[0]
  		when 'Q'
	  		new :type => parts[0],
	  				:qname => parts[1],
	  				:qclass => parts[2],
	  				:qtype => parts[3],
	  				:id => parts[4],
	  				:remote_ip_address => parts[5],
	  				:local_ip_address => parts[6],
	  				:edns_subnet_address => parts[7]
	  	when 'lookup'
	  		new :type => parts[0],
	  				:qtype => parts[1],
	  				:qname => parts[2],
	  				:zone_id => parts[3],
	  				:remote => parts[5],
	  				:local => parts[6],
	  				:real_remote => parts[7]
	  	when 'PING'
	  		new :type => parts[0]
	  	when 'AXFR'
	  		new :type => parts[0],
	  		    :id => parts[1]
	  	else
	  		raise PDNSError, 'not a valid question'
	  	end
  	end

  	def regular_query?
  		self.type == 'Q'
  	end

  	def list_request?
  		self.type == 'AXFR'
  	end

  	def ping_request?
  		self.type == 'PING'
  	end

  	def lookup_query?
  		self.type == 'lookup'
  	end

    def to_json
      MultiJson.dump(self, :adapter => :yajl, :pretty => true)
    end

  end
end