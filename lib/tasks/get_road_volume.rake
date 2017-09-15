require 'active_support/core_ext/time'

desc 'Runs road volume methods'
task :fetch_road_volume => :environment do
  # time check so it only runs between 6AM - 9PM
  if Time.zone.now.hour >= 6 && Time.zone.now.hour <= 21
    west_volume = TrafficVolume.get_road_volume('West')
    east_volume = TrafficVolume.get_road_volume('East')
    puts "West Volume #{west_volume.volume} at #{west_volume.time}"
    puts "East Volume #{east_volume.volume} at #{east_volume.time}"
  end 
  
end