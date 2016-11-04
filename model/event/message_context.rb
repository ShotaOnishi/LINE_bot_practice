class MessageContext
  attr_reader :value
  attr_accessor :formatter

  def initialize(formatter, value=nil)
    @formatter = formatter
    unless value.nil?
      @value = value
    end
  end

  def output_message
    @formatter.output_message(self)
  end
end