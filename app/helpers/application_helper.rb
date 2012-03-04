# -*- coding: utf-8 -*-
module ApplicationHelper
  def full_title(page_title)
    "品酷" + (page_title.blank? ? "" : " | #{page_title}")
  end
end
