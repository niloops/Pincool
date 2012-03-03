class DemosController < ApplicationController

  def upyun
    secret_key = "piE8AyMbVx5rn7HTp3wuJO3R8EM="
    policydoc = {
      "bucket" => "pincool-photo",
      "expiration" => 5.minutes.since.to_i,
      "save-key" => "/demo/{filemd5}{.suffix}",
      "allow-file-type" => "jpg,jpeg,gif,png",
      "content-length-range" => "0,#{2.megabyte}"
    }
    @policy = Base64.strict_encode64(policydoc.to_json)
    @signature = Digest::MD5.hexdigest("#{@policy}&#{secret_key}")
  end

  def omniauth
    render xml: request.env['omniauth.auth']
  end
  
end
