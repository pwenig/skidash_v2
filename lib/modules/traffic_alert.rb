# Module for the CDOT API alerts and speeds data
module TrafficAlert
  class << self
    def get_alerts(road)
      if @alert_response
        get_ski_alerts(@alert_response, road)
      else
        @alert_response = TrafficApi.road_alerts
        get_ski_alerts(@alert_response, road) if @alert_response
      end
    end

    def get_images(road)
      if @image_response
        get_ski_images(@image_response, road)
      else
        @image_response = TrafficApi.road_images
        get_ski_images(@image_response, road) if @image_response
      end
    end

    def get_speeds(road)
      if @speed_response
        get_ski_speeds(@speed_response, road)
      else
        @speed_response = TrafficApi.road_speeds
        get_ski_speeds(@speed_response, road) if @speed_response
      end
    end

    private

    def get_ski_images(response, road)
      road_images = []
      response['CameraDetails']['Camera'].each do |camera|
        road_images << camera['CameraView']
      end
      images = road_images.flatten
      sort_images(images, road)
    end

    def sort_images(images, road)
      selected_images = []
      images.each do |image|
        selected_images << image if image['RoadName'] == road
      end

      if road == 'I-70'
        selected_images = selected_images.select { |x| 
            x['CameraId'] == '11130' || x['CameraId'] == '10134' ||
            x['CameraId'] == '10085' || x['CameraId'] == '10517' ||
            x['CameraId'] == '11118' || x['CameraId'] == '11202' ||
            x['CameraId'] == '10139' || x['CameraId'] == '10883' 
        }
      end
      selected_images
    end

    def get_ski_speeds(response, road)
      speed_segments = []
      response['SpeedDetails']['Segment'].each do |speed_segment|
        if speed_segment['RoadName'] == road && speed_segment['AverageSpeed'] != '-1' && speed_segment['AverageSpeed'].to_i < 50
          index = speed_segment['SegmentName'].index('-')
          speed_segment['SegmentName'].slice!(0..index) unless index.nil?
          speed_segments << speed_segment
        end
      end
      if road == 'I-70'
        road_speeds = speed_segments.select { |x| TrafficApi.selected_road_segments.include?(x['SegmentId']) }
      else
        road_speeds = speed_segments
      end

      road_speeds.sort_by! { |k| k['SegmentId'] }
      road_speeds.sort_by! { |k| k['Direction'] }
    end

    def get_ski_alerts(response, road)
      alert_messages = []
      alert_description = {}
      response['Alerts']['Alert'].each do |alert|
        if alert['RoadName'] == road && alert['TypeId'] != '1'
          alert_description['Description'] = alert['Description'].gsub(/<[^>]*>/, '')
          alert_messages << alert.select { |x| x['LocationDescription'] || x['Title'] || x['RoadName'] }.merge(alert_description)
        end
      end

      if alert_messages.count == 0
        no_alerts = {}
        no_alerts['Title'] = 'No Alerts'
        no_alerts['Headline'] = ''
        no_alerts['Description'] = ''

        alert_messages << no_alerts
      end

      alert_messages
    end

  end

end
