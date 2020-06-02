class Cheatsheet < ApplicationRecord
  belongs_to :user

  scope :public_cheatsheets, -> { where("public = ?", true).order(updated_at: :desc) }

  def recently_created
    created_at >= 24.hour.ago
  end

  def recently_updated
    updated_at >= 3.days.ago
  end

  def private?
    public == false
  end
end
