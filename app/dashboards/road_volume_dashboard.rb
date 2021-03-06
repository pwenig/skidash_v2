require "administrate/base_dashboard"

class RoadVolumeDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    direction: Field::String,
    volume: Field::String,
    time: Field::String,
    month: Field::String,
    day: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :direction,
    :volume,
    :time,
    :month,
    :day
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :direction,
    :volume,
    :time,
    :month,
    :day,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :direction,
    :volume,
    :month,
    :day,
    :time,
  ].freeze

  # Overwrite this method to customize how road volumes are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(road_volume)
  #   "RoadVolume ##{road_volume.id}"
  # end
end
