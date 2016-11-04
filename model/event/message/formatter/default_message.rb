
class DefaultMessage
  def output_message(context)
    {
        type: "text",
        text: context.value['message']['text']
    }
  end
end