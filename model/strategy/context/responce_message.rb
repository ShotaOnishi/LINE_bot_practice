class ResponceMessage
  attr_reader :event
  attr_accessor :formatter

  def initialize(formatter, event=nil)
    @formatter = formatter
    unless event.nil?
      @event = event
    end
  end

  def output_message
    @formatter.output_message(self)
  end
end