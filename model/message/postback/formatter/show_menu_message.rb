class ShowMenuMessage
  def initialize(model, category)
    @model = model
    @category = category
  end

  def output_message(context)
    {
        "type": "template",
        "altText": "this is a carousel template",
        "template": {
            "type": "carousel",
            "columns": make_colums
        }
    }
  end

  def choose_category()
    if @category == 'DON'
      return '丼'
    elsif @category == 'MEN'
      return '麺類'
    elsif @category == 'DES'
      return 'デザート'
    end
  end

  def make_colums()
    colums = []
    for m in @model.where('category':choose_category)
      colums.append(
          {
              "thumbnailImageUrl": m.picture,
              "title": m.name,
              "text": m.price,
              "actions": [
                  {
                      "type": "postback",
                      "label": "Order",
                      "data": "action=order&itemid=" + m.id.to_s
                  },
                  {
                      "type": "postback",
                      "label": "Add to cart",
                      "data": "action=add&itemid=" + m.id.to_s
                  },
                  {
                      "type": "uri",
                      "label": "View detail",
                      "uri": "http://example.com/page/111"
                  }
              ]
          }
      )
    end
    colums
  end
end