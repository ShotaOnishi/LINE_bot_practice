
class DefaultMessage
  def output_message(context)
    {
        type: "text",
        text: context.event.message['text']
    }
  end
end