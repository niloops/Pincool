Rails.application.config.middleware.use OmniAuth::Builder do
  provider :weibo, '3193838520', '2f64e93fcccb131233405b894c8af83a'
  provider :douban, '02bc820da7a5acd908358628f6f1068b', 'aca9709901509efa'
end
