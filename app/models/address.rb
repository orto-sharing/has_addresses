# Represents a generic mailing address. Addresses are expected to consist of
# the following fields:
# * +addressable+ - The record that owns the address
# * +street_1+ - The first line of the street address
# * +city+ - The name of the city
# * +postal_code+ - A value uniquely identifying the area in the city
# * +region+ - Either a known region or a custom value for countries that have no list of regions available
# * +country+ - The country, which may be implied by the region
# 
# The following fields are optional:
# * +street_2+ - The second line of the street address
# 
# There is no attempt to validate open-ended fields since the context in which
# the addresses will be used is unknown
class Address < ActiveRecord::Base
  belongs_to :addressable, :polymorphic => true
  belongs_to :region
  belongs_to :country
  
  validates_presence_of :addressable_id, :addressable_type, :street_1, :city,
                        :postal_code, :country_id
  validates_presence_of :region_id, :if => :known_region_required?
  validates_presence_of :custom_region, :if => :custom_region_required?
  
  attr_accessible :street_1, :street_2, :city, :postal_code, :region,
                  :custom_region, :country
  
  before_validation :ensure_exclusive_references, :set_region_attributes

  enum address_type: [:home, :office, :other]
  
  # Gets the name of the region that this address is for (whether it is a
  # custom or known region in the database)
  def region_name
    custom_region || region && region.name
  end
  
  # Gets a representation of the address on a single line.
  # 
  # For example,
  # 
  #   address = Address.new
  #   address.single_line     # => ""
  #   
  #   address.street_1 = "1600 Amphitheatre Parkey"
  #   address.single_line     # => "1600 Amphitheatre Parkway"
  #   
  #   address.street_2 = "Suite 100"
  #   address.single_line     # => "1600 Amphitheatre Parkway, Suite 100"
  #   
  #   address.city = "Mountain View"
  #   address.single_line     # => "1600 Amphitheatre Parkway, Suite 100, Mountain View"
  #   
  #   address.region = Region['US-CA']
  #   address.single_line     # => "1600 Amphitheatre Parkway, Suite 100, Mountain View, California, United States"
  #   
  #   address.postal_code = '94043'
  #   address.single_line     # => "1600 Amphitheatre Parkway, Suite 100, Mountain View, California  94043, United States"
  def single_line
    multi_line.join(', ')
  end
  
  # Gets a representation of the address on multiple lines.
  # 
  # For example,
  # 
  #   address = Address.new
  #   address.multi_line      # => []
  #   
  #   address.street_1 = "1600 Amphitheatre Parkey"
  #   address.multi_line      # => ["1600 Amphitheatre Parkey"]
  #   
  #   address.street_2 = "Suite 100"
  #   address.multi_line      # => ["1600 Amphitheatre Parkey", "Suite 100"]
  #   
  #   address.city = "Mountain View"
  #   address.multi_line      # => ["1600 Amphitheatre Parkey", "Suit 100", "Mountain View"]
  #   
  #   address.region = Region['US-CA']
  #   address.multi_line      # => ["1600 Amphitheatre Parkey", "Suit 100", "Mountain View, California", "United States"]
  #   
  #   address.postal_code = '94043'
  #   address.multi_line      # => ["1600 Amphitheatre Parkey", "Suit 100", "Mountain View, California  94043", "United States"]
  def multi_line
    lines = []
    lines << street_1 if street_1?
    lines << street_2 if street_2?
    
    line = ''
    line << city if city?
    if region_name
      line << ', ' unless line.blank?
      line << region_name
    end
    if postal_code?
      line << '  ' unless line.blank?
      line << postal_code
    end
    lines << line unless line.blank?
    
    lines << country.name if country
    lines
  end
  
  private
    # Does the current country have a list of regions to choose from?
    def known_region_required?
      !country || country.regions.any?
    end
    
    # A custom region name is required if a known region was not specified and
    # the country in which this address resides has no known regions in the
    # database
    def custom_region_required?
      !region_id && country && country.regions.empty?
    end
    
    # Ensures that the custom region is not set at the same time as the known
    # region
    def ensure_exclusive_references
      self.custom_region = nil if known_region_required?
    end
    
    # Sets the attributes on the address based on the region (if available)
    def set_region_attributes

      enumerable :address_type, []
      self.country = region.country if region
    end
end
