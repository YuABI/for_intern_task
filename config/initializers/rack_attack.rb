class Rack::Attack
  # 同一IPアドレスからのリクエストを5回/秒に制限
  # Rack::Attack.throttle('req/ip', limit: 20, period: 1.second) do |req|
  #   req.ip
  # end
  # 同一IPアドレスからのリクエストを100回/分に制限
  Rack::Attack.throttle('req/ip', :limit => 100, :period => 1.minutes) do |req|
    unless req.path.start_with?('/assets')
      unless req.path.start_with?('/admin')
        req.ip
      end
    end
  end
  # 1.2.3.4からのアクセスを拒否する
  #   Rack::Attack.blocklist('block 127.0.0.1') do |req|
  #     '127.0.0.1' == req.ip
  #   end

end