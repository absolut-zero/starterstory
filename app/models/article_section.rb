class ArticleSection < ApplicationRecord
  belongs_to :business_idea
  belongs_to :article
end
