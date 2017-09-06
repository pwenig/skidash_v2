module TrafficAlert

  @auth = {:username => "#{ENV['CDOT_USERNAME']}", :password => "#{ENV['CDOT_PASSWORD']}"}

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

end

