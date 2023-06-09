class Publication < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :reactions, dependent: :destroy
  has_many :users, through: :reactions
  
  Kinds = %w[like dislike].freeze
  KindsSpanish = {"like" => "Me gusta", "dislike" => "No me gusta"}.freeze

  def likes_count
    reactions.where(kind: 'like').count
  end

  def dislikes_count
    reactions.where(kind: 'dislike').count
  end
end
