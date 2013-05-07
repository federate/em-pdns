module PDNS
  class Stack

    attr_accessor :options

    def initialize(options = {}, &block)
      @middlewares, @options = [],  Hashie::Mash.new(options)
      instance_eval(&block) if block_given?
    end

    def use(middleware, *args, &block)
      @middlewares << proc { |app| middleware.new(app, *args, &block) }
    end

    def app
      @app ||= begin
        to_app(@run || lambda { |env|
          env.status = :complete if env.status == :processing
          env
        })
      end
    end

    def run(&blk)
      @run = blk
    end

    def to_app(inner_app)
      @middlewares.reverse.inject(inner_app) { |a,e| e[a] }
    end

    def call(env)
      self.app.call(env)
    end

    def process_request(request, &callback)
      env = Hashie::Mash.new
      env.request = request
      env.middleware_info = {}
      env.errors = []
      env.status = :processing

      begin
        result = self.app.call(env)
      rescue Exception => e
        SIPRedirector.logger.error e.message
        SIPRedirector.logger.error e.backtrace.join("\n")
      end

      callback.call(result) if callback

      result
    end