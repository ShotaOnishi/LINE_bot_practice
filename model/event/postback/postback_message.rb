
class PostbackMessage
  def initial(context)
    @context = context
  end

  def output_message()
    hash = @context.value
    if hash.has_key?('category')
      category = q_hash['category']
      message = MessageContext.new(ShowMenuMessage.new(Menu, category))
      if category == 'befDON'
        message = MessageContext.new(ShowDonMessage.new('丼'))
      elsif category == 'befMEN'
        message = MessageContext.new(ShowDonMessage.new('麺類'))
      elsif category == 'befDES'
        message = MessageContext.new(ShowDonMessage.new('デザート'))
      end
    elsif hash.has_key?('action')
      action = q_hash['action']
      if action == 'order'
        message = MessageContext.new(OrderCompleteMessage.new())
      end
    else
      exit 1
    end

    message.output_message
  end
end