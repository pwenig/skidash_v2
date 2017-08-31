module TrafficAlert

  def self.get_alerts
    auth = {:username => "#{ENV['CDOT_USERNAME']}", :password => "#{ENV['CDOT_PASSWORD']}"}
    response =  HTTParty.get("#{ENV['CDOT_URL']}", :basic_auth => auth)
    alerts = get_ski_alerts(response)
   
  end 

  private

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

