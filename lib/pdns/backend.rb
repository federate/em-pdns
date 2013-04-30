module PDNS
  module Backend

    def answer(opts = {})
      Answer.new opts
    end

  end
end