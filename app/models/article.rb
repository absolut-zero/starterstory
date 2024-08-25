class Article < ApplicationRecord
  has_many :article_sections
  has_many :business_ideas, through: :article_sections
end
