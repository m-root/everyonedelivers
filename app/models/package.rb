class Package < ActiveRecord::Base
  has_one :delivery

  def apply_form_attributes(params)
    return if params.nil?

    if params[:description]
      self.description = params[:description]
    end
    if params[:height]
      self.height_in_meters = inches_to_meters(params[:height])
    end
    if params[:width]
      self.width_in_meters = inches_to_meters(params[:width])
    end
    if params[:depth]
      self.depth_in_meters = inches_to_meters(params[:depth])
    end
    if params[:weight]
      self.weight_in_grams = ounces_to_grams(params[:weight])
    end
    if params[:display_price]
      self.price_in_cents = (params[:display_price].to_f*100).to_i
    end
  end

  def ok_to_display?
    description && description.size > 0
  end

  def has_dimensions?
    height_in_meters && width_in_meters && depth_in_meters
  end

  def height
    "%0.1f" % meters_to_inches(self.height_in_meters)
  end

  def width
    "%0.1f" % meters_to_inches(self.width_in_meters)
  end

  def depth
    "%0.1f" % meters_to_inches(self.depth_in_meters)
  end

  def weight
    "%0.1f" % grams_to_ounces(self.weight_in_grams)
  end

  def inches_to_meters(inch_s)
    inch_s.to_f*0.0254
  end

  def meters_to_inches(meters)
    meters/0.0254
  end

  def ounces_to_grams(ounces_s)
    ounces_s.to_f*28.3495
  end

  def grams_to_ounces(meters)
    weight_in_grams/28.3495
  end

  def display_price
    "%0.2f" % float_price
  end

  def float_price
    if self.price_in_cents
      self.price_in_cents / 100.0
    else
      0.0
    end
  end
end
