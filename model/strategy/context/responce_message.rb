class ResponceMessage
  attr_accessor :formatter

  def initialize(formatter)
    @formatter = formatter
  end

  def self.init_with_event(formatter, event)
    @event = event
    @formatter = formatter
  end

  def output_message
    @formatter.output_message(self)
  end
end