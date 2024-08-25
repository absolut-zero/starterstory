class BusinessIdea < ApplicationRecord
  has_many :article_sections
  has_many :articles, through: :article_sections
end
