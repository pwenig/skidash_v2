desc 'Runs road volume methods'
task :fetch_road_volume => :environment do
  west_volume = TrafficVolume.get_road_volume('West')
  east_volume = TrafficVolume.get_road_volume('East')
end