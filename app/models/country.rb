# coding: utf-8
# Defined by the ISO 3166 standard.  The ISO 3166 standard includes a
# "Country Subdivision Code", giving a code for the names of the principal
# administrative subdivisions of the countries coded in ISO 3166.
# 
# Data is based on http://svn.debian.org/wsvn/pkg-isocodes/trunk/iso-codes/iso_3166/iso_3166.xml?op=file
# 
# Countries are uniquely identified by their alpha 2 code.  You can access
# countries like so:
# 
#   Country['US']   # => #<Country id: 840, alpha_2_code: "US", name: "United States", official_name: "United States of America", alpha_3_code: "USA">
#   Country['CA']   # => #<Country id: 124, alpha_2_code: "CA", name: "Canada", official_name: "Canada", alpha_3_code: "CAN">
# 
# == Identification
# 
# Country ids are based on another ISO standard which assigns a numeric value
# to every country.
# 
# == Regions
# 
# Each country may or may not have a list of regions associated with it.  It
# is largely based on the ISO standard for each country.
# 
# == Performance
# 
# If plugin reloading is enabled or this model is added to your app,
# consider marking the file as unloadable like so (in the environment):
# 
#   config.after_initialize do
#     ActiveSupport::Dependencies.load_once_paths << "#{Rails.root}/vendor/plugins/has_addresses/app/models/country" # or "#{Rails.root}/app/models/country"
#   end
# 
# This will prevent the enumeration from being bootstrapped after every
# request when in development mode.
class Country < ActiveRecord::Base
  enumerate_by :alpha_2_code
  
  has_many :regions
  has_many :addresses
  
  validates_presence_of :name, :official_name, :alpha_3_code
  validates_length_of :alpha_2_code, :is => 2
  validates_length_of :alpha_3_code, :is => 3
  
  alias_attribute :abbreviation_2, :alpha_2_code
  alias_attribute :abbreviation_3, :alpha_3_code
  
  def initialize(attributes = nil) #:nodoc:
    super(self.class.with_defaults(attributes))
  end
  
  # Adds the default attributes for the given country attributes
  def self.with_defaults(attributes = nil)
    attributes ||= {}
    attributes.symbolize_keys!
    attributes[:official_name] = attributes[:name] unless attributes.include?(:official_name)
    attributes
  end
  
  fast_bootstrap([
    {:id => 4, :name => "Afghanistan", :official_name => "Islamic Republic of Afghanistan", :alpha_2_code => 'AF', :alpha_3_code => 'AFG'},
    {:id => 8, :name => "Albania", :official_name => "Republic of Albania", :alpha_2_code => 'AL', :alpha_3_code => 'ALB'},
    {:id => 10, :name => "Antarctica", :alpha_2_code => 'AQ', :alpha_3_code => 'ATA'},
    {:id => 12, :name => "Algeria", :official_name => "People's Democratic Republic of Algeria", :alpha_2_code => 'DZ', :alpha_3_code => 'DZA'},
    {:id => 16, :name => "American Samoa", :alpha_2_code => 'AS', :alpha_3_code => 'ASM'},
    {:id => 20, :name => "Andorra", :official_name => "Principality of Andorra", :alpha_2_code => 'AD', :alpha_3_code => 'AND'},
    {:id => 24, :name => "Angola", :official_name => "Republic of Angola", :alpha_2_code => 'AO', :alpha_3_code => 'AGO'},
    {:id => 28, :name => "Antigua and Barbuda", :alpha_2_code => 'AG', :alpha_3_code => 'ATG'},
    {:id => 31, :name => "Azerbaijan", :official_name => "Republic of Azerbaijan", :alpha_2_code => 'AZ', :alpha_3_code => 'AZE'},
    {:id => 32, :name => "Argentina", :official_name => "Argentine Republic", :alpha_2_code => 'AR', :alpha_3_code => 'ARG'},
    {:id => 36, :name => "Australia", :alpha_2_code => 'AU', :alpha_3_code => 'AUS'},
    {:id => 40, :name => "Austria", :official_name => "Republic of Austria", :alpha_2_code => 'AT', :alpha_3_code => 'AUT'},
    {:id => 44, :name => "Bahamas", :official_name => "Commonwealth of the Bahamas", :alpha_2_code => 'BS', :alpha_3_code => 'BHS'},
    {:id => 48, :name => "Bahrain", :official_name => "Kingdom of Bahrain", :alpha_2_code => 'BH', :alpha_3_code => 'BHR'},
    {:id => 50, :name => "Bangladesh", :official_name => "People's Republic of Bangladesh", :alpha_2_code => 'BD', :alpha_3_code => 'BGD'},
    {:id => 51, :name => "Armenia", :official_name => "Republic of Armenia", :alpha_2_code => 'AM', :alpha_3_code => 'ARM'},
    {:id => 52, :name => "Barbados", :alpha_2_code => 'BB', :alpha_3_code => 'BRB'},
    {:id => 56, :name => "Belgium", :official_name => "Kingdom of Belgium", :alpha_2_code => 'BE', :alpha_3_code => 'BEL'},
    {:id => 60, :name => "Bermuda", :alpha_2_code => 'BM', :alpha_3_code => 'BMU'},
    {:id => 64, :name => "Bhutan", :official_name => "Kingdom of Bhutan", :alpha_2_code => 'BT', :alpha_3_code => 'BTN'},
    {:id => 68, :name => "Bolivia", :official_name => "Republic of Bolivia", :alpha_2_code => 'BO', :alpha_3_code => 'BOL'},
    {:id => 70, :name => "Bosnia and Herzegovina", :official_name => "Republic of Bosnia and Herzegovina", :alpha_2_code => 'BA', :alpha_3_code => 'BIH'},
    {:id => 72, :name => "Botswana", :official_name => "Republic of Botswana", :alpha_2_code => 'BW', :alpha_3_code => 'BWA'},
    {:id => 74, :name => "Bouvet Island", :alpha_2_code => 'BV', :alpha_3_code => 'BVT'},
    {:id => 76, :name => "Brazil", :official_name => "Federative Republic of Brazil", :alpha_2_code => 'BR', :alpha_3_code => 'BRA'},
    {:id => 84, :name => "Belize", :alpha_2_code => 'BZ', :alpha_3_code => 'BLZ'},
    {:id => 86, :name => "British Indian Ocean Territory", :alpha_2_code => 'IO', :alpha_3_code => 'IOT'},
    {:id => 90, :name => "Solomon Islands", :alpha_2_code => 'SB', :alpha_3_code => 'SLB'},
    {:id => 92, :name => "Virgin Islands, British", :official_name => "British Virgin Islands", :alpha_2_code => 'VG', :alpha_3_code => 'VGB'},
    {:id => 96, :name => "Brunei Darussalam", :alpha_2_code => 'BN', :alpha_3_code => 'BRN'},
    {:id => 100, :name => "Bulgaria", :official_name => "Republic of Bulgaria", :alpha_2_code => 'BG', :alpha_3_code => 'BGR'},
    {:id => 104, :name => "Myanmar", :official_name => "Union of Myanmar", :alpha_2_code => 'MM', :alpha_3_code => 'MMR'},
    {:id => 108, :name => "Burundi", :official_name => "Republic of Burundi", :alpha_2_code => 'BI', :alpha_3_code => 'BDI'},
    {:id => 112, :name => "Belarus", :official_name => "Republic of Belarus", :alpha_2_code => 'BY', :alpha_3_code => 'BLR'},
    {:id => 116, :name => "Cambodia", :official_name => "Kingdom of Cambodia", :alpha_2_code => 'KH', :alpha_3_code => 'KHM'},
    {:id => 120, :name => "Cameroon", :official_name => "Republic of Cameroon", :alpha_2_code => 'CM', :alpha_3_code => 'CMR'},
    {:id => 124, :name => "Canada", :alpha_2_code => 'CA', :alpha_3_code => 'CAN'},
    {:id => 132, :name => "Cape Verde", :official_name => "Republic of Cape Verde", :alpha_2_code => 'CV', :alpha_3_code => 'CPV'},
    {:id => 136, :name => "Cayman Islands", :alpha_2_code => 'KY', :alpha_3_code => 'CYM'},
    {:id => 140, :name => "Central African Republic", :alpha_2_code => 'CF', :alpha_3_code => 'CAF'},
    {:id => 144, :name => "Sri Lanka", :official_name => "Democratic Socialist Republic of Sri Lanka", :alpha_2_code => 'LK', :alpha_3_code => 'LKA'},
    {:id => 148, :name => "Chad", :official_name => "Republic of Chad", :alpha_2_code => 'TD', :alpha_3_code => 'TCD'},
    {:id => 152, :name => "Chile", :official_name => "Republic of Chile", :alpha_2_code => 'CL', :alpha_3_code => 'CHL'},
    {:id => 156, :name => "China", :official_name => "People's Republic of China", :alpha_2_code => 'CN', :alpha_3_code => 'CHN'},
    {:id => 158, :name => "Taiwan", :official_name => "Taiwan, Province of China", :alpha_2_code => 'TW', :alpha_3_code => 'TWN'},
    {:id => 162, :name => "Christmas Island", :alpha_2_code => 'CX', :alpha_3_code => 'CXR'},
    {:id => 166, :name => "Cocos (Keeling) Islands", :alpha_2_code => 'CC', :alpha_3_code => 'CCK'},
    {:id => 170, :name => "Colombia", :official_name => "Republic of Colombia", :alpha_2_code => 'CO', :alpha_3_code => 'COL'},
    {:id => 174, :name => "Comoros", :official_name => "Union of the Comoros", :alpha_2_code => 'KM', :alpha_3_code => 'COM'},
    {:id => 175, :name => "Mayotte", :alpha_2_code => 'YT', :alpha_3_code => 'MYT'},
    {:id => 178, :name => "Congo", :official_name => "Republic of the Congo", :alpha_2_code => 'CG', :alpha_3_code => 'COG'},
    {:id => 180, :name => "Congo, Democratic Republic of", :official_name => "Congo, The Democratic Republic of the", :alpha_2_code => 'CD', :alpha_3_code => 'COD'},
    {:id => 184, :name => "Cook Islands", :alpha_2_code => 'CK', :alpha_3_code => 'COK'},
    {:id => 188, :name => "Costa Rica", :official_name => "Republic of Costa Rica", :alpha_2_code => 'CR', :alpha_3_code => 'CRI'},
    {:id => 191, :name => "Croatia", :official_name => "Republic of Croatia", :alpha_2_code => 'HR', :alpha_3_code => 'HRV'},
    {:id => 192, :name => "Cuba", :official_name => "Republic of Cuba", :alpha_2_code => 'CU', :alpha_3_code => 'CUB'},
    {:id => 196, :name => "Cyprus", :official_name => "Republic of Cyprus", :alpha_2_code => 'CY', :alpha_3_code => 'CYP'},
    {:id => 203, :name => "Czech Republic", :alpha_2_code => 'CZ', :alpha_3_code => 'CZE'},
    {:id => 204, :name => "Benin", :official_name => "Republic of Benin", :alpha_2_code => 'BJ', :alpha_3_code => 'BEN'},
    {:id => 208, :name => "Denmark", :official_name => "Kingdom of Denmark", :alpha_2_code => 'DK', :alpha_3_code => 'DNK'},
    {:id => 212, :name => "Dominica", :official_name => "Commonwealth of Dominica", :alpha_2_code => 'DM', :alpha_3_code => 'DMA'},
    {:id => 214, :name => "Dominican Republic", :alpha_2_code => 'DO', :alpha_3_code => 'DOM'},
    {:id => 218, :name => "Ecuador", :official_name => "Republic of Ecuador", :alpha_2_code => 'EC', :alpha_3_code => 'ECU'},
    {:id => 222, :name => "El Salvador", :official_name => "Republic of El Salvador", :alpha_2_code => 'SV', :alpha_3_code => 'SLV'},
    {:id => 226, :name => "Equatorial Guinea", :official_name => "Republic of Equatorial Guinea", :alpha_2_code => 'GQ', :alpha_3_code => 'GNQ'},
    {:id => 231, :name => "Ethiopia", :official_name => "Federal Democratic Republic of Ethiopia", :alpha_2_code => 'ET', :alpha_3_code => 'ETH'},
    {:id => 232, :name => "Eritrea", :alpha_2_code => 'ER', :alpha_3_code => 'ERI'},
    {:id => 233, :name => "Estonia", :official_name => "Republic of Estonia", :alpha_2_code => 'EE', :alpha_3_code => 'EST'},
    {:id => 234, :name => "Faroe Islands", :alpha_2_code => 'FO', :alpha_3_code => 'FRO'},
    {:id => 238, :name => "Falkland Islands", :official_name => "Falkland Islands (Malvinas)", :alpha_2_code => 'FK', :alpha_3_code => 'FLK'},
    {:id => 239, :name => "South Georgia", :official_name => "South Georgia and the South Sandwich Islands", :alpha_2_code => 'GS', :alpha_3_code => 'SGS'},
    {:id => 242, :name => "Fiji", :official_name => "Republic of the Fiji Islands", :alpha_2_code => 'FJ', :alpha_3_code => 'FJI'},
    {:id => 246, :name => "Finland", :official_name => "Republic of Finland", :alpha_2_code => 'FI', :alpha_3_code => 'FIN'},
    {:id => 248, :name => "Åland Islands", :alpha_2_code => 'AX', :alpha_3_code => 'ALA'},
    {:id => 250, :name => "France", :official_name => "French Republic", :alpha_2_code => 'FR', :alpha_3_code => 'FRA'},
    {:id => 254, :name => "French Guiana", :alpha_2_code => 'GF', :alpha_3_code => 'GUF'},
    {:id => 258, :name => "French Polynesia", :alpha_2_code => 'PF', :alpha_3_code => 'PYF'},
    {:id => 260, :name => "French Southern Territories", :alpha_2_code => 'TF', :alpha_3_code => 'ATF'},
    {:id => 262, :name => "Djibouti", :official_name => "Republic of Djibouti", :alpha_2_code => 'DJ', :alpha_3_code => 'DJI'},
    {:id => 266, :name => "Gabon", :official_name => "Gabonese Republic", :alpha_2_code => 'GA', :alpha_3_code => 'GAB'},
    {:id => 268, :name => "Georgia", :alpha_2_code => 'GE', :alpha_3_code => 'GEO'},
    {:id => 270, :name => "Gambia", :official_name => "Republic of the Gambia", :alpha_2_code => 'GM', :alpha_3_code => 'GMB'},
    {:id => 275, :name => "Palestinian Territories", :official_name => "Occupied Palestinian Territory", :alpha_2_code => 'PS', :alpha_3_code => 'PSE'},
    {:id => 276, :name => "Germany", :official_name => "Federal Republic of Germany", :alpha_2_code => 'DE', :alpha_3_code => 'DEU'},
    {:id => 288, :name => "Ghana", :official_name => "Republic of Ghana", :alpha_2_code => 'GH', :alpha_3_code => 'GHA'},
    {:id => 292, :name => "Gibraltar", :alpha_2_code => 'GI', :alpha_3_code => 'GIB'},
    {:id => 296, :name => "Kiribati", :official_name => "Republic of Kiribati", :alpha_2_code => 'KI', :alpha_3_code => 'KIR'},
    {:id => 300, :name => "Greece", :official_name => "Hellenic Republic", :alpha_2_code => 'GR', :alpha_3_code => 'GRC'},
    {:id => 304, :name => "Greenland", :alpha_2_code => 'GL', :alpha_3_code => 'GRL'},
    {:id => 308, :name => "Grenada", :alpha_2_code => 'GD', :alpha_3_code => 'GRD'},
    {:id => 312, :name => "Guadeloupe", :alpha_2_code => 'GP', :alpha_3_code => 'GLP'},
    {:id => 316, :name => "Guam", :alpha_2_code => 'GU', :alpha_3_code => 'GUM'},
    {:id => 320, :name => "Guatemala", :official_name => "Republic of Guatemala", :alpha_2_code => 'GT', :alpha_3_code => 'GTM'},
    {:id => 324, :name => "Guinea", :official_name => "Republic of Guinea", :alpha_2_code => 'GN', :alpha_3_code => 'GIN'},
    {:id => 328, :name => "Guyana", :official_name => "Republic of Guyana", :alpha_2_code => 'GY', :alpha_3_code => 'GUY'},
    {:id => 332, :name => "Haiti", :official_name => "Republic of Haiti", :alpha_2_code => 'HT', :alpha_3_code => 'HTI'},
    {:id => 334, :name => "Heard and McDonald Islands", :official_name => "Heard Island and McDonald ", :alpha_2_code => 'HM', :alpha_3_code => 'HMD'},
    {:id => 336, :name => "Holy See (Vatican City State)", :alpha_2_code => 'VA', :alpha_3_code => 'VAT'},
    {:id => 340, :name => "Honduras", :official_name => "Republic of Honduras", :alpha_2_code => 'HN', :alpha_3_code => 'HND'},
    {:id => 344, :name => "Hong Kong", :official_name => "Hong Kong Special Administrative Region of China", :alpha_2_code => 'HK', :alpha_3_code => 'HKG'},
    {:id => 348, :name => "Hungary", :official_name => "Republic of Hungary", :alpha_2_code => 'HU', :alpha_3_code => 'HUN'},
    {:id => 352, :name => "Iceland", :official_name => "Republic of Iceland", :alpha_2_code => 'IS', :alpha_3_code => 'ISL'},
    {:id => 356, :name => "India", :official_name => "Republic of India", :alpha_2_code => 'IN', :alpha_3_code => 'IND'},
    {:id => 360, :name => "Indonesia", :official_name => "Republic of Indonesia", :alpha_2_code => 'ID', :alpha_3_code => 'IDN'},
    {:id => 364, :name => "Iran", :official_name => "Islamic Republic of Iran", :alpha_2_code => 'IR', :alpha_3_code => 'IRN'},
    {:id => 368, :name => "Iraq", :official_name => "Republic of Iraq", :alpha_2_code => 'IQ', :alpha_3_code => 'IRQ'},
    {:id => 372, :name => "Ireland", :alpha_2_code => 'IE', :alpha_3_code => 'IRL'},
    {:id => 376, :name => "Israel", :official_name => "State of Israel", :alpha_2_code => 'IL', :alpha_3_code => 'ISR'},
    {:id => 380, :name => "Italy", :official_name => "Italian Republic", :alpha_2_code => 'IT', :alpha_3_code => 'ITA'},
    {:id => 384, :name => "Côte d'Ivoire", :official_name => "Republic of Côte d'Ivoire", :alpha_2_code => 'CI', :alpha_3_code => 'CIV'},
    {:id => 388, :name => "Jamaica", :alpha_2_code => 'JM', :alpha_3_code => 'JAM'},
    {:id => 392, :name => "Japan", :alpha_2_code => 'JP', :alpha_3_code => 'JPN'},
    {:id => 398, :name => "Kazakhstan", :official_name => "Republic of Kazakhstan", :alpha_2_code => 'KZ', :alpha_3_code => 'KAZ'},
    {:id => 400, :name => "Jordan", :official_name => "Hashemite Kingdom of Jordan", :alpha_2_code => 'JO', :alpha_3_code => 'JOR'},
    {:id => 404, :name => "Kenya", :official_name => "Republic of Kenya", :alpha_2_code => 'KE', :alpha_3_code => 'KEN'},
    {:id => 408, :name => "North Korea", :official_name => "Democratic People's Republic of Korea", :alpha_2_code => 'KP', :alpha_3_code => 'PRK'},
    {:id => 410, :name => "South Korea", :official_name => "Republic of Korea", :alpha_2_code => 'KR', :alpha_3_code => 'KOR'},
    {:id => 414, :name => "Kuwait", :official_name => "State of Kuwait", :alpha_2_code => 'KW', :alpha_3_code => 'KWT'},
    {:id => 417, :name => "Kyrgyzstan", :official_name => "Kyrgyz Republic", :alpha_2_code => 'KG', :alpha_3_code => 'KGZ'},
    {:id => 418, :name => "Laos", :official_name => "Lao People's Democratic Republic", :alpha_2_code => 'LA', :alpha_3_code => 'LAO'},
    {:id => 422, :name => "Lebanon", :official_name => "Lebanese Republic", :alpha_2_code => 'LB', :alpha_3_code => 'LBN'},
    {:id => 426, :name => "Lesotho", :official_name => "Kingdom of Lesotho", :alpha_2_code => 'LS', :alpha_3_code => 'LSO'},
    {:id => 428, :name => "Latvia", :official_name => "Republic of Latvia", :alpha_2_code => 'LV', :alpha_3_code => 'LVA'},
    {:id => 430, :name => "Liberia", :official_name => "Republic of Liberia", :alpha_2_code => 'LR', :alpha_3_code => 'LBR'},
    {:id => 434, :name => "Libya", :official_name => "Socialist People's Libyan Arab Jamahiriya", :alpha_2_code => 'LY', :alpha_3_code => 'LBY'}, # Libyan Arab Jamahiriya
    {:id => 438, :name => "Liechtenstein", :official_name => "Principality of Liechtenstein", :alpha_2_code => 'LI', :alpha_3_code => 'LIE'},
    {:id => 440, :name => "Lithuania", :official_name => "Republic of Lithuania", :alpha_2_code => 'LT', :alpha_3_code => 'LTU'},
    {:id => 442, :name => "Luxembourg", :official_name => "Grand Duchy of Luxembourg", :alpha_2_code => 'LU', :alpha_3_code => 'LUX'},
    {:id => 446, :name => "Macao", :official_name => "Macao Special Administrative Region of China", :alpha_2_code => 'MO', :alpha_3_code => 'MAC'},
    {:id => 450, :name => "Madagascar", :official_name => "Republic of Madagascar", :alpha_2_code => 'MG', :alpha_3_code => 'MDG'},
    {:id => 454, :name => "Malawi", :official_name => "Republic of Malawi", :alpha_2_code => 'MW', :alpha_3_code => 'MWI'},
    {:id => 458, :name => "Malaysia", :alpha_2_code => 'MY', :alpha_3_code => 'MYS'},
    {:id => 462, :name => "Maldives", :official_name => "Republic of Maldives", :alpha_2_code => 'MV', :alpha_3_code => 'MDV'},
    {:id => 466, :name => "Mali", :official_name => "Republic of Mali", :alpha_2_code => 'ML', :alpha_3_code => 'MLI'},
    {:id => 470, :name => "Malta", :official_name => "Republic of Malta", :alpha_2_code => 'MT', :alpha_3_code => 'MLT'},
    {:id => 474, :name => "Martinique", :alpha_2_code => 'MQ', :alpha_3_code => 'MTQ'},
    {:id => 478, :name => "Mauritania", :official_name => "Islamic Republic of Mauritania", :alpha_2_code => 'MR', :alpha_3_code => 'MRT'},
    {:id => 480, :name => "Mauritius", :official_name => "Republic of Mauritius", :alpha_2_code => 'MU', :alpha_3_code => 'MUS'},
    {:id => 484, :name => "Mexico", :official_name => "United Mexican States", :alpha_2_code => 'MX', :alpha_3_code => 'MEX'},
    {:id => 492, :name => "Monaco", :official_name => "Principality of Monaco", :alpha_2_code => 'MC', :alpha_3_code => 'MCO'},
    {:id => 498, :name => "Moldova", :official_name => "Republic of Moldova", :alpha_2_code => 'MD', :alpha_3_code => 'MDA'},
    {:id => 496, :name => "Mongolia", :alpha_2_code => 'MN', :alpha_3_code => 'MNG'},
    {:id => 499, :name => "Montenegro", :official_name => "Republic of Montenegro", :alpha_2_code => 'ME', :alpha_3_code => 'MNE'},
    {:id => 500, :name => "Montserrat", :alpha_2_code => 'MS', :alpha_3_code => 'MSR'},
    {:id => 504, :name => "Morocco", :official_name => "Kingdom of Morocco", :alpha_2_code => 'MA', :alpha_3_code => 'MAR'},
    {:id => 508, :name => "Mozambique", :official_name => "Republic of Mozambique", :alpha_2_code => 'MZ', :alpha_3_code => 'MOZ'},
    {:id => 512, :name => "Oman", :official_name => "Sultanate of Oman", :alpha_2_code => 'OM', :alpha_3_code => 'OMN'},
    {:id => 516, :name => "Namibia", :official_name => "Republic of Namibia", :alpha_2_code => 'NA', :alpha_3_code => 'NAM'},
    {:id => 520, :name => "Nauru", :official_name => "Republic of Nauru", :alpha_2_code => 'NR', :alpha_3_code => 'NRU'},
    {:id => 524, :name => "Nepal", :official_name => "Kingdom of Nepal", :alpha_2_code => 'NP', :alpha_3_code => 'NPL'},
    {:id => 528, :name => "Netherlands", :official_name => "Kingdom of the Netherlands", :alpha_2_code => 'NL', :alpha_3_code => 'NLD'},
    {:id => 530, :name => "Netherlands Antilles", :alpha_2_code => 'AN', :alpha_3_code => 'ANT'},
    {:id => 533, :name => "Aruba", :alpha_2_code => 'AW', :alpha_3_code => 'ABW'},
    {:id => 540, :name => "New Caledonia", :alpha_2_code => 'NC', :alpha_3_code => 'NCL'},
    {:id => 548, :name => "Vanuatu", :official_name => "Republic of Vanuatu", :alpha_2_code => 'VU', :alpha_3_code => 'VUT'},
    {:id => 554, :name => "New Zealand", :alpha_2_code => 'NZ', :alpha_3_code => 'NZL'},
    {:id => 558, :name => "Nicaragua", :official_name => "Republic of Nicaragua", :alpha_2_code => 'NI', :alpha_3_code => 'NIC'},
    {:id => 562, :name => "Niger", :official_name => "Republic of the Niger", :alpha_2_code => 'NE', :alpha_3_code => 'NER'},
    {:id => 566, :name => "Nigeria", :official_name => "Federal Republic of Nigeria", :alpha_2_code => 'NG', :alpha_3_code => 'NGA'},
    {:id => 570, :name => "Niue", :official_name => "Republic of Niue", :alpha_2_code => 'NU', :alpha_3_code => 'NIU'},
    {:id => 574, :name => "Norfolk Island", :alpha_2_code => 'NF', :alpha_3_code => 'NFK'},
    {:id => 578, :name => "Norway", :official_name => "Kingdom of Norway", :alpha_2_code => 'NO', :alpha_3_code => 'NOR'},
    {:id => 580, :name => "Northern Mariana Islands", :official_name => "Commonwealth of the Northern Mariana Islands", :alpha_2_code => 'MP', :alpha_3_code => 'MNP'},
    {:id => 581, :name => "U.S. Minor Outlying Islands", :official_name => "United States Minor Outlying Islands", :alpha_2_code => 'UM', :alpha_3_code => 'UMI'},
    {:id => 583, :name => "Micronesia", :official_name => "Federated States of Micronesia", :alpha_2_code => 'FM', :alpha_3_code => 'FSM'},
    {:id => 584, :name => "Marshall Islands", :official_name => "Republic of the Marshall Islands", :alpha_2_code => 'MH', :alpha_3_code => 'MHL'},
    {:id => 585, :name => "Palau", :official_name => "Republic of Palau", :alpha_2_code => 'PW', :alpha_3_code => 'PLW'},
    {:id => 586, :name => "Pakistan", :official_name => "Islamic Republic of Pakistan", :alpha_2_code => 'PK', :alpha_3_code => 'PAK'},
    {:id => 591, :name => "Panama", :official_name => "Republic of Panama", :alpha_2_code => 'PA', :alpha_3_code => 'PAN'},
    {:id => 598, :name => "Papua New Guinea", :alpha_2_code => 'PG', :alpha_3_code => 'PNG'},
    {:id => 600, :name => "Paraguay", :official_name => "Republic of Paraguay", :alpha_2_code => 'PY', :alpha_3_code => 'PRY'},
    {:id => 604, :name => "Peru", :official_name => "Republic of Peru", :alpha_2_code => 'PE', :alpha_3_code => 'PER'},
    {:id => 608, :name => "Philippines", :official_name => "Republic of the Philippines", :alpha_2_code => 'PH', :alpha_3_code => 'PHL'},
    {:id => 612, :name => "Pitcairn", :alpha_2_code => 'PN', :alpha_3_code => 'PCN'},
    {:id => 616, :name => "Poland", :official_name => "Republic of Poland", :alpha_2_code => 'PL', :alpha_3_code => 'POL'},
    {:id => 620, :name => "Portugal", :official_name => "Portuguese Republic", :alpha_2_code => 'PT', :alpha_3_code => 'PRT'},
    {:id => 624, :name => "Guinea-Bissau", :official_name => "Republic of Guinea-Bissau", :alpha_2_code => 'GW', :alpha_3_code => 'GNB'},
    {:id => 626, :name => "Timor-Leste", :official_name => "Democratic Republic of Timor-Leste", :alpha_2_code => 'TL', :alpha_3_code => 'TLS'},
    {:id => 630, :name => "Puerto Rico", :alpha_2_code => 'PR', :alpha_3_code => 'PRI'},
    {:id => 634, :name => "Qatar", :official_name => "State of Qatar", :alpha_2_code => 'QA', :alpha_3_code => 'QAT'},
    {:id => 638, :name => "Reunion", :alpha_2_code => 'RE', :alpha_3_code => 'REU'},
    {:id => 642, :name => "Romania", :alpha_2_code => 'RO', :alpha_3_code => 'ROU'},
    {:id => 643, :name => "Russian Federation", :alpha_2_code => 'RU', :alpha_3_code => 'RUS'},
    {:id => 646, :name => "Rwanda", :official_name => "Rwandese Republic", :alpha_2_code => 'RW', :alpha_3_code => 'RWA'},
    {:id => 652, :name => "Saint Barthélemy", :alpha_2_code => 'BL', :alpha_3_code => 'BLM'},
    {:id => 654, :name => "St. Helena", :official_name => "Saint Helena", :alpha_2_code => 'SH', :alpha_3_code => 'SHN'},
    {:id => 659, :name => "St. Kitts and Nevis", :official_name => "Saint Kitts and Nevis", :alpha_2_code => 'KN', :alpha_3_code => 'KNA'},
    {:id => 660, :name => "Anguilla", :alpha_2_code => 'AI', :alpha_3_code => 'AIA'},
    {:id => 662, :name => "St. Lucia", :official_name => "Saint Lucia", :alpha_2_code => 'LC', :alpha_3_code => 'LCA'},
    {:id => 663, :name => "St. Martin (French part)", :official_name => "Saint Martin (French part)", :alpha_2_code => 'MF', :alpha_3_code => 'MAF'},
    {:id => 666, :name => "St. Pierre and Miquelon", :official_name => "Saint Pierre and Miquelon", :alpha_2_code => 'PM', :alpha_3_code => 'SPM'},
    {:id => 670, :name => "St. Vincent and the Grenadines", :official_name => "Saint Vincent and the Grenadines", :alpha_2_code => 'VC', :alpha_3_code => 'VCT'},
    {:id => 674, :name => "San Marino", :official_name => "Republic of San Marino", :alpha_2_code => 'SM', :alpha_3_code => 'SMR'},
    {:id => 678, :name => "Sao Tome and Principe", :official_name => "Democratic Republic of Sao Tome and Principe", :alpha_2_code => 'ST', :alpha_3_code => 'STP'},
    {:id => 682, :name => "Saudi Arabia", :official_name => "Kingdom of Saudi Arabia", :alpha_2_code => 'SA', :alpha_3_code => 'SAU'},
    {:id => 686, :name => "Senegal", :official_name => "Republic of Senegal", :alpha_2_code => 'SN', :alpha_3_code => 'SEN'},
    {:id => 688, :name => "Serbia", :official_name => "Republic of Serbia", :alpha_2_code => 'RS', :alpha_3_code => 'SRB'},
    {:id => 690, :name => "Seychelles", :official_name => "Republic of Seychelles", :alpha_2_code => 'SC', :alpha_3_code => 'SYC'},
    {:id => 694, :name => "Sierra Leone", :official_name => "Republic of Sierra Leone", :alpha_2_code => 'SL', :alpha_3_code => 'SLE'},
    {:id => 702, :name => "Singapore", :official_name => "Republic of Singapore", :alpha_2_code => 'SG', :alpha_3_code => 'SGP'},
    {:id => 703, :name => "Slovakia", :official_name => "Slovak Republic", :alpha_2_code => 'SK', :alpha_3_code => 'SVK'},
    {:id => 704, :name => "Viet Nam", :official_name => "Socialist Republic of Viet Nam", :alpha_2_code => 'VN', :alpha_3_code => 'VNM'},
    {:id => 705, :name => "Slovenia", :official_name => "Republic of Slovenia", :alpha_2_code => 'SI', :alpha_3_code => 'SVN'},
    {:id => 706, :name => "Somalia", :official_name => "Somali Republic", :alpha_2_code => 'SO', :alpha_3_code => 'SOM'},
    {:id => 710, :name => "South Africa", :official_name => "Republic of South Africa", :alpha_2_code => 'ZA', :alpha_3_code => 'ZAF'},
    {:id => 716, :name => "Zimbabwe", :official_name => "Republic of Zimbabwe", :alpha_2_code => 'ZW', :alpha_3_code => 'ZWE'},
    {:id => 724, :name => "Spain", :official_name => "Kingdom of Spain", :alpha_2_code => 'ES', :alpha_3_code => 'ESP'},
    {:id => 732, :name => "Western Sahara", :alpha_2_code => 'EH', :alpha_3_code => 'ESH'},
    {:id => 736, :name => "Sudan", :official_name => "Republic of the Sudan", :alpha_2_code => 'SD', :alpha_3_code => 'SDN'},
    {:id => 740, :name => "Suriname", :official_name => "Republic of Suriname", :alpha_2_code => 'SR', :alpha_3_code => 'SUR'},
    {:id => 744, :name => "Svalbard and Jan Mayen", :alpha_2_code => 'SJ', :alpha_3_code => 'SJM'},
    {:id => 748, :name => "Swaziland", :official_name => "Kingdom of Swaziland", :alpha_2_code => 'SZ', :alpha_3_code => 'SWZ'},
    {:id => 752, :name => "Sweden", :official_name => "Kingdom of Sweden", :alpha_2_code => 'SE', :alpha_3_code => 'SWE'},
    {:id => 756, :name => "Switzerland", :official_name => "Swiss Confederation", :alpha_2_code => 'CH', :alpha_3_code => 'CHE'},
    {:id => 760, :name => "Syrian Arab Republic", :alpha_2_code => 'SY', :alpha_3_code => 'SYR'},
    {:id => 762, :name => "Tajikistan", :official_name => "Republic of Tajikistan", :alpha_2_code => 'TJ', :alpha_3_code => 'TJK'},
    {:id => 764, :name => "Thailand", :official_name => "Kingdom of Thailand", :alpha_2_code => 'TH', :alpha_3_code => 'THA'},
    {:id => 768, :name => "Togo", :official_name => "Togolese Republic", :alpha_2_code => 'TG', :alpha_3_code => 'TGO'},
    {:id => 772, :name => "Tokelau", :alpha_2_code => 'TK', :alpha_3_code => 'TKL'},
    {:id => 776, :name => "Tonga", :official_name => "Kingdom of Tonga", :alpha_2_code => 'TO', :alpha_3_code => 'TON'},
    {:id => 780, :name => "Trinidad and Tobago", :official_name => "Republic of Trinidad and Tobago", :alpha_2_code => 'TT', :alpha_3_code => 'TTO'},
    {:id => 784, :name => "United Arab Emirates", :alpha_2_code => 'AE', :alpha_3_code => 'ARE'},
    {:id => 788, :name => "Tunisia", :official_name => "Republic of Tunisia", :alpha_2_code => 'TN', :alpha_3_code => 'TUN'},
    {:id => 792, :name => "Turkey", :official_name => "Republic of Turkey", :alpha_2_code => 'TR', :alpha_3_code => 'TUR'},
    {:id => 795, :name => "Turkmenistan", :alpha_2_code => 'TM', :alpha_3_code => 'TKM'},
    {:id => 796, :name => "Turks and Caicos Islands", :alpha_2_code => 'TC', :alpha_3_code => 'TCA'},
    {:id => 798, :name => "Tuvalu", :alpha_2_code => 'TV', :alpha_3_code => 'TUV'},
    {:id => 800, :name => "Uganda", :official_name => "Republic of Uganda", :alpha_2_code => 'UG', :alpha_3_code => 'UGA'},
    {:id => 804, :name => "Ukraine", :alpha_2_code => 'UA', :alpha_3_code => 'UKR'},
    {:id => 807, :name => "Macedonia", :official_name => "The Former Yugoslav Republic of Macedonia", :alpha_2_code => 'MK', :alpha_3_code => 'MKD'},
    {:id => 818, :name => "Egypt", :official_name => "Arab Republic of Egypt", :alpha_2_code => 'EG', :alpha_3_code => 'EGY'},
    {:id => 826, :name => "United Kingdom", :official_name => "United Kingdom of Great Britain and Northern Ireland", :alpha_2_code => 'GB', :alpha_3_code => 'GBR'},
    {:id => 831, :name => "Guernsey", :alpha_2_code => 'GG', :alpha_3_code => 'GGY'},
    {:id => 833, :name => "Isle of Man", :alpha_2_code => 'IM', :alpha_3_code => 'IMN'},
    {:id => 832, :name => "Jersey", :alpha_2_code => 'JE', :alpha_3_code => 'JEY'},
    {:id => 834, :name => "Tanzania", :official_name => "United Republic of Tanzania", :alpha_2_code => 'TZ', :alpha_3_code => 'TZA'},
    {:id => 840, :name => "United States", :official_name => "United States of America", :alpha_2_code => 'US', :alpha_3_code => 'USA'},
    {:id => 850, :name => "Virgin Islands, U.S.", :official_name => "Virgin Islands of the United States", :alpha_2_code => 'VI', :alpha_3_code => 'VIR'},
    {:id => 854, :name => "Burkina Faso", :alpha_2_code => 'BF', :alpha_3_code => 'BFA'},
    {:id => 858, :name => "Uruguay", :official_name => "Eastern Republic of Uruguay", :alpha_2_code => 'UY', :alpha_3_code => 'URY'},
    {:id => 860, :name => "Uzbekistan", :official_name => "Republic of Uzbekistan", :alpha_2_code => 'UZ', :alpha_3_code => 'UZB'},
    {:id => 862, :name => "Venezuela", :official_name => "Bolivarian Republic of Venezuela", :alpha_2_code => 'VE', :alpha_3_code => 'VEN'},
    {:id => 876, :name => "Wallis and Futuna", :alpha_2_code => 'WF', :alpha_3_code => 'WLF'},
    {:id => 882, :name => "Samoa", :official_name => "Independent State of Samoa", :alpha_2_code => 'WS', :alpha_3_code => 'WSM'},
    {:id => 887, :name => "Yemen", :official_name => "Republic of Yemen", :alpha_2_code => 'YE', :alpha_3_code => 'YEM'},
    {:id => 894, :name => "Zambia", :official_name => "Republic of Zambia", :alpha_2_code => 'ZM', :alpha_3_code => 'ZMB'}
  ].map {|attributes| with_defaults(attributes)})
end
