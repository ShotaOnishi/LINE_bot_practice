
class DefaultMessage
  def output_message(context)
    {
        type: "text",
        text: context.events.message['text']
    }
  end
end