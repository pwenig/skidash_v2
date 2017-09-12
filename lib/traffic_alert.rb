module TrafficAlert

  @auth = {:username => "#{ENV['CDOT_USERNAME']}", :password => "#{ENV['CDOT_PASSWORD']}"}

  @selected_road_segments = [20, 21, 22, 23, 24, 25, 266, 267, 268, 269, 27, 270, 271, 272, 273, 274, 275, 276, 277, 28, 29, 30, 31, 32, 33, 34, 36, 37, 38, 40, 41].map(&:to_s)
  

  def self.get_alerts(road)
    if @alert_response
      get_ski_alerts(@alert_response, road)
    else 
      @alert_response =  HTTParty.get("#{ENV['CDOT_ALERT_URL']}", :basic_auth => @auth)
      if @alert_response
        get_ski_alerts(@alert_response, road)
      end
    end 
  end 

  def self.get_images(road)
    if @image_response
      get_ski_images(@image_response, road)
    else 
      @image_response = HTTParty.get("#{ENV['CDOT_IMAGES_URL']}", :basic_auth => @auth)
      if @image_response
        get_ski_images(@image_response, road)
      end 
    end
  end 

  def self.get_speeds(road)
    if @speed_response
      get_ski_speeds(@speed_response, road, false)
    else 
      @speed_response =  HTTParty.get("#{ENV['CDOT_SPEEDS_URL']}", :basic_auth => @auth)
      if @speed_response
        get_ski_speeds(@speed_response, road, false)
      end 
    end
  end

  def self.get_road_volume
    @speed_response =  HTTParty.get("#{ENV['CDOT_SPEEDS_URL']}", :basic_auth => @auth)
    get_volume(@speed_response)
  end 

  private

  def self.get_ski_images(response, road)
    road_images = []
    response['CameraDetails']['Camera'].each do |camera|
      road_images << camera['CameraView']
    end
    images = road_images.flatten
    sort_images(images, road)

  end 

  def self.sort_images(images, road)
    selected_images = []
    display_images = []
    images.each do |image|
      if image['RoadName'] == road
        selected_images << image
      end 
    end 
    
    # Filter out the no image avail ones.
    if road == "I-70"
      display_images << selected_images.select{ |x| x['CameraId'] == '11130' || x['CameraId'] == '10517' || x['CameraId'] == '11118' || x['CameraId'] == '11202' || x['CameraId'] == '10139' || x['CameraId'] == '10883' }
    else
      display_images << selected_images
    end 

    display_images.flatten
  end 

  def self.get_ski_speeds(response, road, all_speeds)
    @speed_segments = []
    response['SpeedDetails']['Segment'].each do |speed_segment|

      # Refactor this!
      if !all_speeds
        if speed_segment['RoadName'] == road && speed_segment['AverageSpeed'] != '-1' && speed_segment['AverageSpeed'].to_i < 50
          index = speed_segment['SegmentName'].index('-')
          if index != nil
            speed_segment['SegmentName'].slice!(0..index) 
          end
          @speed_segments << speed_segment
        end 
      else 
        if speed_segment['RoadName'] == road && speed_segment['AverageVolume'] != '-1'
          index = speed_segment['SegmentName'].index('-')
          if index != nil
            speed_segment['SegmentName'].slice!(0..index) 
          end
          @speed_segments << speed_segment
        end 
      end 
      
    end 
    if road == "I-70"
      road_speeds = @speed_segments.select{ |x| @selected_road_segments.include?(x['SegmentId']) }
    else 
      road_speeds = @speed_segments
    end 
    
    road_speeds.sort_by! { |k| k['SegmentId'] }
    road_speeds.sort_by! { |k| k['Direction'] }

  end 


  def self.get_ski_alerts(response, road)
    alert_messages = []
    alert_description = {}
    response['Alerts']['Alert'].each do |alert|
      if alert['RoadName'] == road && alert['TypeId'] != '1'
        alert_description['Description'] = alert['Description'].gsub(/<[^>]*>/, '')
        alert_messages << alert.select{ |x| x['LocationDescription'] || x['Title'] || x['RoadName'] }.merge(alert_description)
      end 
    end 

    if alert_messages.count == 0
      no_alerts = {}
      no_alerts["Title"] = "No Alerts"
      no_alerts["Headline"] = ''
      no_alerts["Description"] = ''

      alert_messages << no_alerts
    end

    alert_messages
  end 

  def self.get_volume(response)
    road_volume = []
    
    road_segments = get_ski_speeds(response, 'I-70', true)
    # Pull out the SegmentName, Direction, AverageVolume  and save the data
    road_segments.each do |segment|
      volume = {}
      volume['Segment'] = segment['SegmentName']
      volume['Direction'] = segment['Direction']
      volume['AvgVolume'] = segment['AverageVolume']
      volume['DateTime'] = segment['CalculatedDate']
      road_volume << volume
    end

    # Calc eastbound volume & save
    # Calc westbound volume & save
    average_volume = calculcate_average_volume(road_volume.select{ |road| road['Direction'] == 'West'})
    average_volume = calculcate_average_volume(road_volume.select{ |road| road['Direction'] == 'East'})
    

  end 

  def self.calculcate_average_volume(road_volume)
    total = 0
    average = {}
    road_volume.each do |volume|
      total = total + volume['AvgVolume'].to_i
    end
    average['Direction'] = road_volume[0]['Direction']
    average['RoadVolume'] = total / road_volume.length
    average['Time'] = road_volume[0]['DateTime']
    average
  end 

end

