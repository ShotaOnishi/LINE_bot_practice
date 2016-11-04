class ShowDonMessage
  def initialize(key)
        @key = key
  end
  def output_message(context)
    menus = self.choice_image(@key)
    order = []
    menus.each_with_index do |menu, i|
        order[i] = menu
    end
    {
        "type": "template",
        "altText": "this is a carousel template",
        "template": {
            "type": "carousel",
            "columns": [
                {
                    "thumbnailImageUrl": order[0].picture.to_s,
                    "title": order[0].name.to_s,
                    "text": order[0].price.to_s,
                    "actions": [
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
                    "thumbnailImageUrl": order[1].picture.to_s,
                    "title": order[1].name.to_s,
                    "text": order[1].price.to_s,
                    "actions": [
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
                    "thumbnailImageUrl": order[2].picture.to_s,
                    "title": order[2].name.to_s,
                    "text": order[2].price.to_s,
                    "actions": [
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
  end
  def choice_image(key)
    # images = [
    #     'https://pbs.twimg.com/media/B_QHDbSVEAA1adJ.jpg',
    #     'https://pbs.twimg.com/media/BuHSdwCCAAELvUK.jpg',
    #     'https://i.ytimg.com/vi/6nQyHeiDHu0/hqdefault.jpg',
    #     'https://s-media-cache-ak0.pinimg.com/564x/f2/a2/4f/f2a24f58f13823def4053e1ae32f2557.jpg',
    #     'https://pbs.twimg.com/media/CZQMsB-UYAQ-GJA.jpg',
    #     'https://ssl-stat.amebame.com/pub/content/8265872137/user/article/194267610976870743/ea20fa0d12335b8b2735d1a768d0932a/cached.jpg',
    #     'https://s-media-cache-ak0.pinimg.com/236x/f6/5c/8d/f65c8dfee01d6407e9e9cd8298cbeb5d.jpg',
    #     'https://pbs.twimg.com/media/CMTT-vPUAAErxqJ.png',
    #     'https://pbs.twimg.com/media/Bc7INKDCQAAp1d8.jpg',
    #     'https://pbs.twimg.com/media/B5RSK0pCYAA45il.png'
    # ]
    # images.sample
    menus = []
    menus = Menu.where(category: key)
end
end