# Module for the CDOT road volume and calculations
module TrafficVolume
  class << self

    def get_road_volume(direction)
      @speed_response = TrafficApi.road_speeds
      get_volume(@speed_response, direction)
    end

    private 

    def get_volume(response, direction)
      road_volume = []

      road_segments = get_speeds(response)
      road_segments.each do |segment|
        volume = {}
        volume['Segment'] = segment['SegmentName']
        volume['Direction'] = segment['Direction']
        volume['AvgVolume'] = segment['AverageVolume']
        volume['DateTime'] = segment['CalculatedDate']
        road_volume << volume
      end
      calculcate_average_volume(road_volume.select { |road| road['Direction'] == direction })
    end

    def calculcate_average_volume(road_volume)
      total = 0
      average = {}
      road_volume.each do |volume|
        total += volume['AvgVolume'].to_i
      end
      average['Direction'] = road_volume[0]['Direction']
      average['RoadVolume'] = total / road_volume.length
      average['Time'] = road_volume[0]['DateTime'].to_datetime.strftime('%a %b %e %Y %I:%M %p')
      save_road_volume(average)
    end

    def save_road_volume(average)
      RoadVolume.create(direction: average['Direction'], volume: average['RoadVolume'], time: average['Time'])
    end 
    
    def get_speeds(response)
      @speed_segments = []
      response['SpeedDetails']['Segment'].each do |speed_segment|
        if speed_segment['RoadName'] == 'I-70' && speed_segment['AverageVolume'] != '-1'
          index = speed_segment['SegmentName'].index('-')
          speed_segment['SegmentName'].slice!(0..index) unless index.nil?
          @speed_segments << speed_segment
        end
      end
      @speed_segments.select { |x| TrafficApi.selected_road_segments.include?(x['SegmentId']) }
    end
  end
end
