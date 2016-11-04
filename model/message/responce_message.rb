class ResponceMessage
  attr_reader :event
  attr_accessor :formatter

  def initialize(formatter, value=nil)
    @formatter = formatter
    unless value.nil?
      @event = value
    end
  end

  def output_message
    @formatter.output_message(self)
  end
end