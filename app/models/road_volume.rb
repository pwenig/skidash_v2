# RoadVolume class
class RoadVolume < ActiveRecord::Base
  class << self
    # Data for the graph
    def get_road_volume(direction)
      volumes = []
      # Only want today's volume
      all_volume = RoadVolume.where("month = ? AND day = ?", Time.zone.now.month.to_s, Time.zone.now.day.to_s)
      all_volume.each do |volume|
        if volume['direction'] == direction
          data = []
          data << volume['time'][16..volume['time'].length]
          data << volume['volume']
          volumes << data
        end 
      end 
      volumes
    end 
  end 
end
