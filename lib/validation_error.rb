class ValidationError < StandardError
  attr_accessor :record
  
  # 
  def initialize(*opts)
    if opts.length==1
        if opts[0].respond_to?('errors')
          @record = opts[0]
          super("Validation error: ")
        else
          @record = nil
          super(opts[0].to_s)
        end
    else opts.length==2
      super(opts[0])
      @record = opts[1]
    end
  end

  # 
  def to_s
    (@record.present? ? @record.errors.full_messages.flatten.inspect : super)
  end

  def full_messages
    @record.present? ? @record.errors.full_messages : [self.message]
  end

  # 
  def as_json(opts={})
    (@record.present? ? @record.errors : [self.message]).as_json(opts)
  end
end