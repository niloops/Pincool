class UpYun
  def initialize(type)
    @memos = {
      logo: {
        bucket: "pincool-brand-logo",
        secret: "ABT8rJDmWw9WcPPHv35oeYxVO4k="
      },
      photo: {
        bucket: "pincool-photo",
        secret: "piE8AyMbVx5rn7HTp3wuJO3R8EM="
      }
    }[type]
    @domain = "http://#{@memos[:bucket]}.b0.upaiyun.com"
  end

  def policy
    @policy ||= Base64.strict_encode64({
      "bucket" => @memos[:bucket],
      "expiration" => 5.minutes.since.to_i,
      "save-key" => "/{filemd5}{.suffix}",
      "allow-file-type" => "jpg,jpeg,gif,png",
      "return-url" => @return_url,
      "content-length-range" => "0,#{2.megabyte}"
    }.to_json)
  end

  def signature
    @signature ||= Digest::MD5.hexdigest("#{policy}&#{@memos[:secret]}")
  end

  def data(return_url)
    @return_url = return_url
    {
      'data-policy' => policy,
      'data-signature' => signature,
      'data-url' => "http://v0.api.upyun.com/#{@memos[:bucket]}",
      'data-domain' => @domain,
      'data-result-url' => url('/stub_path', :big)
    }
  end

  def url(path, thumb)
    size = case thumb
           when :big
             80
           when :small
             40
           end
    "#{@domain}#{path}!#{size}"
  end
end
