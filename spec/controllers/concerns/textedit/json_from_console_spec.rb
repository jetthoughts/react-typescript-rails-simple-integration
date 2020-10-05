# require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')
# require './app/controllers/concerns/textedit/json_from_console'
# require_relative 'js'

require 'digest'

describe JsonFromConsole do
  include JsonFromConsole

  context 'converter' do
    it 'should decipher the link' do
      link='http://cs-customer-notification-eu.amazon.com:17810/getNotificationContentPost?RTN.MessageID=urn%3Artn%3Amsg%3A20200805111032815945bf547944068df811715820p0eu&shipTrackEventCode=EVENT_307&orderId=304-1943067-4463569&carrierType=3P&isEeylops=true&eventType=ScheduledDeliveryReminder-Email&orderingShipmentIds=23513063050302&fulfillmentShipmentId=36407097860202&marketplaceId=4&countOfShipmentsInTheLargestOrder=1&customerId=A3TNRF0J47TXSQ&recipient=bernhard.rubenbauer%40web.de&numberOfShipmentItemEntitiesInTheLargestOrder=1&orderIds=304-1943067-4463569&RTN.RetryCount=1&trackingId=002200218206210000B00011'
      res = make_output link
      # expect(res).to match 'hello'
      expect(res).to match_snapshot 'hello'
    end

    it 'should handle match failures gracefully' do
      bad_link='cs-customer-notification-.amazon.com:17810/getNotificationContentPost?RTN.MessageID=urn%3Artn%3Amsg%3A20200805111032815945bf547944068df811715820p0eu&shipTrackEventCode=EVENT_307&orderId=304-1943067-4463569&carrierType=3P&isEeylops=true&eventType=ScheduledDeliveryReminder-Email&orderingShipmentIds=23513063050302&fulfillmentShipmentId=36407097860202&marketplaceId=4&countOfShipmentsInTheLargestOrder=1&customerId=A3TNRF0J47TXSQ&recipient=bernhard.rubenbauer%40web.de&numberOfShipmentItemEntitiesInTheLargestOrder=1&orderIds=304-1943067-4463569&RTN.RetryCount=1&trackingId=002200218206210000B00011'
      expect {make_output bad_link}.to raise_error(RegexpError)
    end

    it 'should encode repetably to MD5' do
      # Compute a complete digest
      a = Digest::MD5.hexdigest 'abc'
      b = Digest::MD5.hexdigest 'abc'
      expect(a).to match b
      expect(a).to match_snapshot 'md5a'
      expect(b).to match_snapshot 'md5a'
    end
  end
end
