
class GooMessage
  def output_message(context)
    # encoding: utf-8
    require 'net/https'
    require 'json'
    app_id = ENV['GOO_API_KEY']
    request_data = {'app_id'=>app_id, "sentence"=>context.value['message']['text']}.to_json
    header = {'Content-type'=>'application/json'}
    https = Net::HTTP.new('labs.goo.ne.jp', 443)
    https.use_ssl=true
    responce = https.post('/api/entity', request_data, header)
    result = JSON.parse(responce.body)
    puts result
    {
      type: "text",
      text: context.value['message']['text']
    }
  end
end