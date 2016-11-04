
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
    result['ne_list'].each do |val, cate|
      context.value['message']['text'] = context.value['message']['text'] + "\n地名:#{val}" if cate == 'LOC'
      context.value['message']['text'] = context.value['message']['text'] + "\n日付:#{val}" if cate == 'DAT'
      context.value['message']['text'] = context.value['message']['text'] + "\n人工物:#{val}" if cate == 'ART'
      context.value['message']['text'] = context.value['message']['text'] + "\n組織:#{val}" if cate == 'ORG'
      context.value['message']['text'] = context.value['message']['text'] + "\n人名:#{val}" if cate == 'PSN'
      context.value['message']['text'] = context.value['message']['text'] + "\n時刻:#{val}" if cate == 'TIM'


    end

    {
      type: "text",
      text: context.value['message']['text']
    }
  end
end