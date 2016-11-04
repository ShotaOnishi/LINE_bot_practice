
class OrderCompleteMessage
  def output_message(context)
    {
       "type":  "text",
       "text": name + "を注文しました"
    }
  end
end