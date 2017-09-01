module TrafficAlert

  @auth = {:username => "#{ENV['CDOT_USERNAME']}", :password => "#{ENV['CDOT_PASSWORD']}"}

  def self.get_alerts
    response =  HTTParty.get("#{ENV['CDOT_ALERT_URL']}", :basic_auth => @auth)
    get_ski_alerts(response)
   
  end 

  def self.get_images
    response = HTTParty.get("#{ENV['CDOT_IMAGES_URL']}", :basic_auth => @auth)
    get_ski_images(response)
    
  end 

  private

  def self.get_ski_images(response)
    road_images = []
    response['CameraDetails']['Camera'].each do |camera|
      road_images << camera['CameraView']
    end 
    sort_images(road_images.flatten)

  end 

  def self.sort_images(images)
    selected_images = []
    display_images = []
    images.each do |image|
      if image['RoadId'] == '32'
        selected_images << image
      end 
    end 
    display_images << selected_images.select{ |x| x['CameraId'] == '11130' || x['CameraId'] == '10517' || x['CameraId'] == '11118' || x['CameraId'] == '11202' || x['CameraId'] == '10139' || x['CameraId'] == '10883' }
    display_images.flatten
  end 

  def self.get_ski_alerts(response)
    alert_messages = []
    alert_description = {}
    response['Alerts']['Alert'].each do |alert|
      # I-70 is RoadId 32
      if alert['RoadId'] == '32' && alert['Impact'] == 'Severe'
        # Remove any html that is in the desc.
        alert_description['Description'] = alert['Description'].gsub(/<[^>]*>/, '')
        alert_messages << alert.select{ |x| x['LocationDescription'] || x['Title'] }.merge(alert_description)
      end 
    end 

    if alert_messages.count == 0
      no_alerts = {}
      no_alerts["Title"] = "NONE"
      no_alerts["Headline"] = ''
      no_alerts["Description"] = ''

      alert_messages << no_alerts
    end

    alert_messages
  end 

end

