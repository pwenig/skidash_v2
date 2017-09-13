require 'administrate/base_dashboard'

class MountainDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    name: Field::String,
    zip_code: Field::String,
    lifts_open: Field::String,
    runs_open: Field::String,
    terrain_url: Field::String,
    mtn_image1: Field::String,
    mtn_image2: Field::String,
    mtn_image3: Field::String,
    base: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    name
    zip_code
    lifts_open
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    name
    zip_code
    lifts_open
    runs_open
    terrain_url
    mtn_image1
    mtn_image2
    mtn_image3
    base
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    name
    zip_code
    lifts_open
    runs_open
    terrain_url
    mtn_image1
    mtn_image2
    mtn_image3
    base
  ].freeze

  # Overwrite this method to customize how mountains are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(mountain)
  #   "Mountain ##{mountain.id}"
  # end
end
