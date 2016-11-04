
class DefaultMessage
  def output_message(context)
    require "docomoru"
    client = Docomoru::Client.new(api_key: ENV["DOCOMO_API_KEY"])
    response = client.create_dialogue(context.value['message']['text'])
    context.value['message']['text'] = response.body["utt"]
    {
      type: "text",
      text: context.value['message']['text']
    }
  end
end