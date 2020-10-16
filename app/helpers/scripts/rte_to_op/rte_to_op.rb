# require_relative '../../../../app/util/text_utils'

module Scripts
  module RteToOp
    # include TextUtil

    MARKETPLACE_OBFS = {}
    MARKETPLACE_OBFS['1'] = "ATVPDKIKX0DER" # US_Prod
    MARKETPLACE_OBFS['3'] = "A1F83G8C2ARO7P" # UK_Prod
    MARKETPLACE_OBFS['4'] = "A1PA6795UKMFR9" # Germany_Prod
    MARKETPLACE_OBFS['5'] = "A13V1IB3VIYZZH" # France_Prod
    MARKETPLACE_OBFS['6'] = "A1VC38T7YXB528" # Japan_Devo/Prod
    MARKETPLACE_OBFS['7'] = "A2EUQ1WTGCTBG2" # Canada_Devo/Prod
    MARKETPLACE_OBFS['3240'] = "AAHKV2X7AFYLW" # China_Prod
    MARKETPLACE_OBFS['12532'] = "A38NPJYVS5YHNH" # Russia_Devo
    MARKETPLACE_OBFS['12542'] = "A1RNPCQ4K8U27I" # Australia_Devo
    MARKETPLACE_OBFS['13152'] = "A34XX9OGNJ8Z6T" # Japan_Devo
    MARKETPLACE_OBFS['35691'] = "APJ6JRA9NG5V4" # Italy_Prod
    MARKETPLACE_OBFS['40232'] = "A9QSUUOYRWVOG" # N/A_Devo
    MARKETPLACE_OBFS['44551'] = "A1RKKUPIHCS9HS" # Spain_Prod
    MARKETPLACE_OBFS['44561'] = "A3M22N3OY5KY7Q" # India_Prod
    MARKETPLACE_OBFS['44571'] = "A21TJRUUN4KGV" # India_Prod
    MARKETPLACE_OBFS['50462'] = "A2QWGHQV78QQMU" # Singapore_Devo
    MARKETPLACE_OBFS['101611'] = "A3HOBANJMCMD83" # Italy_Devo
    MARKETPLACE_OBFS['111162'] = "AD2EMQ3L3PG8S" # Russia_Prod
    MARKETPLACE_OBFS['111172'] = "A39IBJ37TRP1C6" # Australia_Prod
    MARKETPLACE_OBFS['121322'] = "A2MKBGGTHABQEV" # Japan_Prod
    MARKETPLACE_OBFS['123311'] = "AJZF8LZ1EJVJN" # Spain_Devo
    MARKETPLACE_OBFS['123591'] = "A2XZLSVIQ0F4JT" # India_Devo
    MARKETPLACE_OBFS['142980'] = "AZXD3QD5B39HD" # Brazil_Devo
    MARKETPLACE_OBFS['151232'] = "A15PK738MTQHSO" # N/A_Prod
    MARKETPLACE_OBFS['151302'] = "AUK5T4I7X4ZCF" # Singapore_Prod
    MARKETPLACE_OBFS['181720'] = "A3P3J5A7D2ZVXI" # Mexico_Devo
    MARKETPLACE_OBFS['218691'] = "A2D32KE73PNS33" # India_Prod
    MARKETPLACE_OBFS['243811'] = "A1D38IXLEJ6VQC" # India_Devo
    MARKETPLACE_OBFS['260281'] = "A1M3WC0SJ3A38T" # Netherlands_Devo
    MARKETPLACE_OBFS['264730'] = "A25AZXLUQC00VX" # US_Devo
    MARKETPLACE_OBFS['279841'] = "A31S5IEFAOLGXC" # UK_Devo
    MARKETPLACE_OBFS['287991'] = "A39EJH0AK2BYSI" # Italy_Devo
    MARKETPLACE_OBFS['288961'] = "A3FQJJS6CFOOV1" # Spain_Devo
    MARKETPLACE_OBFS['289371'] = "AVFDNTCG43SJ1" # Germany_Devo
    MARKETPLACE_OBFS['300671'] = "A3A7FBE29Z0H2Y" # France_Devo
    MARKETPLACE_OBFS['305631'] = "A1D7Z662KHSYZY" # N/A_Devo
    MARKETPLACE_OBFS['306801'] = "A1MJEQWJOUEPEQ" # N/A_Devo
    MARKETPLACE_OBFS['314421'] = "A34GYYCZVDBSIK" # United Arab Emirates_Devo
    MARKETPLACE_OBFS['314691'] = "A1MQPSGJ6U9Q54" # Saudi Arabia_Devo
    MARKETPLACE_OBFS['316340'] = "A3U49GLEJ1PS4Y" # N/A_Devo
    MARKETPLACE_OBFS['318651'] = "A3CQBQD3RGPJR8" # Turkey_Devo
    MARKETPLACE_OBFS['328451'] = "A1805IZSGTT6HS" # Netherlands_Prod
    MARKETPLACE_OBFS['330551'] = "AM7DNVYQULIQ5" # UK_Prod
    MARKETPLACE_OBFS['330711'] = "A1TERGVA4U2MLK" # Italy_Prod
    MARKETPLACE_OBFS['330731'] = "ACDNLAE5F4JT1" # Spain_Prod
    MARKETPLACE_OBFS['330871'] = "A1KU16HT7ALXJ0" # Germany_Prod
    MARKETPLACE_OBFS['330921'] = "A2905VW864VWWF" # France_Prod
    MARKETPLACE_OBFS['330961'] = "AGJTXQVCWGLM9" # UK_Prod
    MARKETPLACE_OBFS['331021'] = "A2MFUE2XK8ZSSY" # N/A_Prod
    MARKETPLACE_OBFS['331051'] = "A3K6Y4MI8GDYMT" # N/A_Prod
    MARKETPLACE_OBFS['338801'] = "A2VIGQ35RCS4UG" # United Arab Emirates_Prod
    MARKETPLACE_OBFS['338811'] = "A17E79C6D8DWNP" # Saudi Arabia_Prod
    MARKETPLACE_OBFS['338851'] = "A33AVAJ2PDY3EV" # Turkey_Prod
    MARKETPLACE_OBFS['526970'] = "A2Q3Y263D00KWC" # Brazil_Prod
    MARKETPLACE_OBFS['771770'] = "A1AM78C64UM0Y8" # Mexico_Prod
    MARKETPLACE_OBFS['903668'] = "A210MR9VJP84CZ" # Canada_Devo
    MARKETPLACE_OBFS['1338980'] = "A1IXFGJ6ITL7J4" # US_Prod
    MARKETPLACE_OBFS['1367840'] = "A25NTRYU0OUV0L" # US_Prod
    MARKETPLACE_OBFS['1367890'] = "ART4WZ8MWBX2Y" # N/A_Prod
    MARKETPLACE_OBFS['1368230'] = "A2BR6UVHX99FEC" # US_Prod
    MARKETPLACE_OBFS['1398340'] = "AWUFL3O4Q4HZJ" # Canada_Prod
    MARKETPLACE_OBFS['63384901'] = "AUJPM9XGFJRC7" # Egypt_Devo
    MARKETPLACE_OBFS['104444012'] = "A19VAU5U5O7RUS" # Singapore_Prod
    MARKETPLACE_OBFS['114978812'] = "A1DQ6JV7I20JSG" # Singapore_Devo
    MARKETPLACE_OBFS['154936711'] = "AKY4K4WKH21YQ" # Poland_Devo
    MARKETPLACE_OBFS['161450861'] = "AT614YYYNOC1S" # Sweden_Devo
    MARKETPLACE_OBFS['623225021'] = "ARBP9OOSHTCHU" # Egypt_Prod
    MARKETPLACE_OBFS['704403121'] = "A2NODRKZP88ZB9" # Sweden_Prod
    MARKETPLACE_OBFS['712115121'] = "A1C3SOZRARQ6R3" # Poland_Prod

    def run_script(input_params)
      @res = ""
      rte_link = input_params['rte_link']
      # @res = make_output rte_link
      @res = rte_link
      @res
    end

    def make_output link
      render_params = link.gsub(/htt.*cs-customer-notification-.*.amazon.*urn.*rtn.*msg.*?[a-z0-9]*&/, '')
      render_params = render_params.gsub(/&/, '", "').gsub(/=/, '": "')
      json_str = "{\"#{render_params}\"}"
      # json_res = JSON.parse json_str

      regex_region = /http.+cs-customer-notification-([a-z]+).amazon.*urn.*rtn.*msg.*[a-z0-9]*?&/
      region = match_or_throw('region', link, regex_region, 1)
      regex_event = /&eventType=([a-zA-Z0-9_\-]+)&/
      event_type = match_or_throw('event_type', link, regex_event, 1)
      regex_marketplace = '&marketplaceId=([0-9]+)&'
      marketplace = match_or_throw('marketplace', link, regex_marketplace, 1)
      obfs_marketplace = MARKETPLACE_OBFS[marketplace]
      puts "region=#{region} event_type=#{event_type} marketplace=#{marketplace} => #{obfs_marketplace}"

      owlery_preview_link = "https://owlery-#{region}-prod.corp.amazon.com/preview/#{event_type}/#{obfs_marketplace}"
      # link='http://cs-customer-notification-eu.amazon.com:17810/getNotificationContentPost?RTN.MessageID=urn%3Artn%3Amsg%3A20200805111032815945bf547944068df811715820p0eu&shipTrackEventCode=EVENT_307&orderId=304-1943067-4463569&carrierType=3P&isEeylops=true&eventType=ScheduledDeliveryReminder-Email&orderingShipmentIds=23513063050302&fulfillmentShipmentId=36407097860202&marketplaceId=4&countOfShipmentsInTheLargestOrder=1&customerId=A3TNRF0J47TXSQ&recipient=bernhard.rubenbauer%40web.de&numberOfShipmentItemEntitiesInTheLargestOrder=1&orderIds=304-1943067-4463569&RTN.RetryCount=1&trackingId=002200218206210000B00011'
      # result="https://owlery-eu-prod.corp.amazon.com/preview/ScheduledDeliveryReminder-Email/A1PA6795UKMFR9?renderParamsJson=..."
      "#{owlery_preview_link}?renderParamsJson=#{json_str}"
    end

    BadRegexMatchError = Class.new(RegexpError)

    def match_or_throw(match_type, str, regex, match_number)
      mtch = str.match(regex)
      raise RegexpError, "NoMatchs for: `#{match_type}` Regex: #{regex.inspect} in `#{str}`" if mtch.nil? || (mtch.size <= match_number)

      mtch[match_number]
    end
  end


  class RteToOpScript < IScript
    include RteToOp

    def initialize
      ap "init RteToOpScript"
      @this_dir = File.dirname(__FILE__)
    end
  end
end
