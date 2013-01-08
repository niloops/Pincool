# -*- coding: utf-8 -*-
module UsersHelper
  def message_senders(message)
    links = message.senders.map do |sender|
      link_to sender.name, user_path(sender)
    end.take(5).join(',')
    if message.senders.count > 5
      links += "等#{message.senders.count}人"
    end
    raw links
  end
end
