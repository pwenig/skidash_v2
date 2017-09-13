# Module for CDOT API calls
module TrafficApi
  @auth = { username: (ENV['CDOT_USERNAME']).to_s, password: (ENV['CDOT_PASSWORD']).to_s }

  class << self
    def road_alerts
      HTTParty.get((ENV['CDOT_ALERT_URL']).to_s, basic_auth: @auth)
    end 

    def road_images
      HTTParty.get((ENV['CDOT_IMAGES_URL']).to_s, basic_auth: @auth)
    end 

    def road_speeds
      HTTParty.get((ENV['CDOT_SPEEDS_URL']).to_s, basic_auth: @auth)
    end 

    def selected_road_segments
      # Specific I-70 road segments.
      %w[
        20 21 22 23 24 25 266 267 268 269 27 270
        271 272 273 274 275 276 277 28 29 30 31
        32 33 34 36 37 38 40 41
      ]
    end
  end

end 