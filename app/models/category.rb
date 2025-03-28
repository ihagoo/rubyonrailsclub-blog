# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :articles
  has_one_attached :cover_image
end
