require 'sinatra'   # gem 'sinatra'
require 'line/bot'  # gem 'line-bot-api'
require 'json'
require 'rest-client'
require 'active_record'
require 'pg'

# DB設定ファイルの読み込み
# ActiveRecord::Base.configurations = YAML.load_file('database.yml')
# ActiveRecord::Base.establish_connection('production')

# class Menu < ActiveRecord::Base
# end

module Line
  module Bot
    class HTTPClient
      def http(uri)
        proxy = URI(ENV["FIXIE_URL"])
        http = Net::HTTP.new(uri.host, uri.port, proxy.host, proxy.port, proxy.user, proxy.password)
        if uri.scheme == "https"
          http.use_ssl = true
        end

        http
      end
    end
  end
end

def client
  @client ||= Line::Bot::Client.new { |config|
    config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
    config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
  }
end

# get '/db_test' do
#   content_type :json, :charset => 'utf-8'
#   menus = Menu.order("created_at DESC").limit(2)
#   menus.to_json(:root => false)
# end

post '/callback' do
  body = request.body.read

  signature = request.env['HTTP_X_LINE_SIGNATURE']
  unless client.validate_signature(body, signature)
    error 400 do 'Bad Request' end
    end

    events = client.parse_events_from(body)

    events.each { |event|
      if event.message['text'].include?("画像")
        type = 'image'
        response_message = choice_image
      elsif event.message['text'].include?("名言")
        type = 'text'
        response_message = choice_serif
      elsif event.message['text'].include?("住所")
        type = 'location'
        response_message = event.message['text'].delete("住所")
      elsif event.message['text'].include?("スタンプ")
        type = 'sticker'
        packageId = "1"
        stickerId = "1"
      elsif event.message['text'].include?("イメージリンク")
        type = "imagemap"
      elsif event.message['text'].include?("ボタン")
        type = "button"
      elsif event.message['text'].include?("リッチ")
        type = "rich"
      elsif event.message['text'].include?("確認")
        type = "confirm"
      elsif event.message['text'].include?("ミーティング")
        type = "meeting"
      else
        type = 'text'
        response_message = event.message['text']
      end

      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          case type
          when 'text'
            message = {
              type: type,
              text: response_message
            }
          when 'meeting'
            message = {
              type: 'text',
              text: "次回ミーティング日程\n日時：11月1日（火）18:00\n場所：３階リフレッシュルーム\n内容：開発段階のプレビューと追加機能などに関する話し合い"
            }
          when 'image'
            message = {
              type: type,
              originalContentUrl: response_message,
              previewImageUrl: response_message
            }
          when 'location'
            message = {
              "type": type,
              "title": response_message,
              "address": "〒150-0002 東京都渋谷区渋谷２丁目２１−１",
              "latitude": 35.65910807942215,
              "longitude": 139.70372892916203
            }
          when 'sticker'
            message = {
              type: type,
              packageId: packageId,
              stickerId: stickerId
            }
          when 'imagemap'
            message = {
              "type": "imagemap",
              "baseUrl": "https://res.cloudinary.com/hmfnscv52/image/upload/v1475767645/ncsg57zhmhd0zfgqwpq5",
              "altText": "this is an imagemap",
              "baseSize": {
                "height": 1040,
                "width": 1040
                },
                "actions": [
                  {
                    "type": "uri",
                    "linkUri": "https://qiita.com/zakuroishikuro/items/066421bce820e3c73ce9",
                    "area": {
                      "x": 0,
                      "y": 0,
                      "width": 520,
                      "height": 1040
                    }
                    },
                    {
                      "type": "message",
                      "text": "hello",
                      "area": {
                        "x": 520,
                        "y": 0,
                        "width": 520,
                        "height": 1040
                      }
                    }
                  ]
                }
              when 'button'
                message = {
                  "type": "template",
                  "altText": "this is a buttons template",
                  "template": {
                    "type": "buttons",
                    #"thumbnailImageUrl": "https://pbs.twimg.com/media/B_QHDbSVEAA1adJ.jpg",
                    #"title": "Menu",
                    "text": "Please select",
                    "actions": [
                      {
                        "type": "postback",
                        "label": "Buy",
                        "data": "action=buy&itemid=123"
                        },
                        {
                          "type": "postback",
                          "label": "Add to cart",
                          "data": "action=add&itemid=123"
                          },
                          {
                            "type": "uri",
                            "label": "View detail",
                            "uri": "http://example.com/page/123"
                          }
                        ]
                      }
                    }
                  when 'rich'
                    message = {
                      "type": "template",
                      "altText": "this is a carousel template",
                      "template": {
                        "type": "carousel",
                        "columns": [
                          {
                            "thumbnailImageUrl": "https://pbs.twimg.com/media/BuHSdwCCAAELvUK.jpg",
                            "title": "this is menu",
                            "text": "description",
                            "actions": [
                              {
                                "type": "postback",
                                "label": "Buy",
                                "data": "action=buy&itemid=111"
                                },
                                {
                                  "type": "postback",
                                  "label": "Add to cart",
                                  "data": "action=add&itemid=111"
                                  },
                                  {
                                    "type": "uri",
                                    "label": "View detail",
                                    "uri": "http://example.com/page/111"
                                  }
                                ]
                                },
                                {
                                  "thumbnailImageUrl": "https://s-media-cache-ak0.pinimg.com/564x/f2/a2/4f/f2a24f58f13823def4053e1ae32f2557.jpg",
                                  "title": "this is menu",
                                  "text": "description",
                                  "actions": [
                                    {
                                      "type": "postback",
                                      "label": "Buy",
                                      "data": "action=buy&itemid=222"
                                      },
                                      {
                                        "type": "postback",
                                        "label": "Add to cart",
                                        "data": "action=add&itemid=222"
                                        },
                                        {
                                          "type": "uri",
                                          "label": "View detail",
                                          "uri": "http://example.com/page/222"
                                        }
                                      ]
                                    }
                                  ]
                                }
                              }
                            when 'confirm'
                              message = {
                                "type": "template",
                                "altText": "this is a confirm template",
                                "template": {
                                  "type": "confirm",
                                  "text": "Are you sure?",
                                  "actions": [
                                    {
                                      "type": "message",
                                      "label": "Yes",
                                      "text": "yes"
                                      },
                                      {
                                        "type": "message",
                                        "label": "No",
                                        "text": "no"
                                      }
                                    ]
                                  }
                                }
                              end
                              res = client.reply_message(event['replyToken'], message)
                              p res
                            when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
                              response = client.get_message_content(event.message['id'])
                              tf = Tempfile.open("content")
                              tf.write(response.body)
                            end
                          end
                        }
                        "OK"
                      end



                      def choice_image
                        images = [
                          'https://pbs.twimg.com/media/B_QHDbSVEAA1adJ.jpg',
                          'https://pbs.twimg.com/media/BuHSdwCCAAELvUK.jpg',
                          'https://i.ytimg.com/vi/6nQyHeiDHu0/hqdefault.jpg',
                          'https://s-media-cache-ak0.pinimg.com/564x/f2/a2/4f/f2a24f58f13823def4053e1ae32f2557.jpg',
                          'https://pbs.twimg.com/media/CZQMsB-UYAQ-GJA.jpg',
                          'https://ssl-stat.amebame.com/pub/content/8265872137/user/article/194267610976870743/ea20fa0d12335b8b2735d1a768d0932a/cached.jpg',
                          'https://s-media-cache-ak0.pinimg.com/236x/f6/5c/8d/f65c8dfee01d6407e9e9cd8298cbeb5d.jpg',
                          'https://pbs.twimg.com/media/CMTT-vPUAAErxqJ.png',
                          'https://pbs.twimg.com/media/Bc7INKDCQAAp1d8.jpg',
                          'https://pbs.twimg.com/media/B5RSK0pCYAA45il.png'
                        ]
                        images.sample
                      end

                      def choice_serif
                        serifs = [
                          'ゆっくりでもいい。自分の力でやり遂げろ！',
                          'オレは絶対にあきらめん',
                          'キミは牧をも超える器だ！！オレはそう信じている！！',
                          'キミは切れる!!相当切れる!!',
                          '１年にしてすでにこれほどゲームに影響力を及ぼすプレイヤーはそうはいないだろう…キミはとてつもないスターになる…　そんな予感がする…',
                          'よし！！行こうか！　練習だ！！',
                          'オレの監督歴の中で今年のチームが１番練習した １番キツかったはずだ　よくがんばった そろそろMGMが王者になっていいころだ',
                          '敗因はこの私！！MGMの選手たちは最高のプレイをした！！',
                          'あいつも３年間がんばってきた男なんだ 侮ってはいけなかった...',
                          'キミの肉体が…　いや…　細胞が瞬間的に反応した',
                          'そう…　今でいえば　オレが仙道　キミが流川みたいなもんだ',
                          'それはお前だ　「ビッグ・ジュン」',
                          'なぜキミがそこにいるんだぁ!?',
                          '小暮はある程度はなしといていい!!',
                          'キミをでかくすることはできない。たとえオレがどんな名コーチでもな',
                          'もーーー我慢できんっ!!!',
                        ]
                        serifs.sample
                      end