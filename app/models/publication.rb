class Publication < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :reactions

  Kinds = %w[like dislike].freeze
  KindsSpanish = {"like" => "Me gusta", "dislike" => "No me gusta"}.freeze
end
