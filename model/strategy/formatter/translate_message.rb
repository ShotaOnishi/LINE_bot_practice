class TranslateMessage
  def output_message(context)

    #これどこに入れればいいんだろう？
    require "google/cloud/translate"
    api_key = ENV['GOOGLE_TRANSLATE_KEY']
    gcloud = Google::Cloud.new
    translate_client = gcloud.translate api_key
    text = context.event.message['text'].delete("翻訳")
    target = "en"
    translation = translate_client.translate text, to: target
    {
      type: "text",
      text: translation.text
    }
  end
end