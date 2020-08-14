class Category < ApplicationRecord

  validates :title, presence: { message: 'title must exist' }
  validates :title, uniqueness: { message: "名称不能重复" }

  has_ancestry orphan_strategy: :destroy

  has_many :products, dependent: :destroy

  def self.grouped_data
    self.roots.order(weight: :desc).inject([]) do |result, parent|
      row = []
      row << parent
      row << parent.children.order(weight: :desc)
      result << row
    end
  end

  before_validation :correct_ancestry
  private def correct_ancestry
    self.ancestry = nil if self.ancestry.blank?
  end

end
