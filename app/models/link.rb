class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true

  validates :name, :url, presence: true
  validates_format_of :url, with: URI::regexp

  def gist?
    URI.parse(url).host.include?('gist')
  end
end
  
