# Module for the CDOT road volume and calculations
module TrafficVolume
  class << self

    # WIP MORE TO DO HERE!
    def get_road_volume
      @speed_response = TrafficApi.road_speeds
      get_volume(@speed_response)
    end

    private 

    def get_volume(response)
      road_volume = []

      road_segments = get_speeds(response)
      # Pull out the SegmentName, Direction, AverageVolume  and save the data
      road_segments.each do |segment|
        volume = {}
        volume['Segment'] = segment['SegmentName']
        volume['Direction'] = segment['Direction']
        volume['AvgVolume'] = segment['AverageVolume']
        volume['DateTime'] = segment['CalculatedDate']
        road_volume << volume
      end

      calculcate_average_volume(road_volume.select { |road| road['Direction'] == 'West' })
      calculcate_average_volume(road_volume.select { |road| road['Direction'] == 'East' })
    end

    def calculcate_average_volume(road_volume)
      total = 0
      average = {}
      road_volume.each do |volume|
        total += volume['AvgVolume'].to_i
      end
      average['Direction'] = road_volume[0]['Direction']
      average['RoadVolume'] = total / road_volume.length
      average['Time'] = road_volume[0]['DateTime']
      average
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
      road_speeds = @speed_segments.select { |x| TrafficApi.selected_road_segments.include?(x['SegmentId']) }
      road_speeds.sort_by! { |k| k['SegmentId'] }
      road_speeds.sort_by! { |k| k['Direction'] }
    end
  end
end
