require 'observer'
require 'singleton'

class CallbackSubject
  include Observable
  include Singleton

  attr_reader :event

  def initialize
    @event
  end

  def event=(new_event)
    old_event = @event
    @event = new_event
    if old_event != new_event
      changed
      notify_observers(self)
    end
  end
end