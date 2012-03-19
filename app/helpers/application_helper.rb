# -*- coding: utf-8 -*-
module ApplicationHelper
  def full_title(page_title)
    "品酷" + (page_title.blank? ? "" : " | #{page_title}")
  end

  def upyun_file_field_tag(id, type)
    require 'upyun'
    file_field_tag id, UpYun.new(type).data(upyun_redirect_url)
  end

  def image_url(type, path, thumb)
    require 'upyun'
    UpYun.new(type).url(path, thumb)
  end

  def nl2br(html)
    raw(h(html).gsub(/[(\n)(\r)]/, "\n" => "<br/>", "\r" => "" ))
  end
end
