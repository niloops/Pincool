class DemosController < ApplicationController

  def upyun
    secret_key = "piE8AyMbVx5rn7HTp3wuJO3R8EM="
    @policydoc = {
      "bucket" => "pincool-photo",
      "expiration" => 5.minutes.since.to_i,
      "save-key" => "/demo/{filemd5}{.suffix}",
      "allow-file-type" => "jpg,jpeg,gif,png",
      "return-url" => demos_upyun_redirect_url,
      "content-length-range" => "0,#{2.megabyte}"
    }
    @policy = Base64.strict_encode64(@policydoc.to_json)
    @signature = Digest::MD5.hexdigest("#{@policy}&#{secret_key}")
    render layout: false
  end

  def upyun_stub
    render json: {policy: params[:policy], signature: params[:signature]}
  end

  def upyun_redirect
    render json: {code: params[:code], message: params[:message], url: params[:url]}
  end
end
