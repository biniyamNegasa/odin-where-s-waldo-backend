class Timer < ApplicationRecord
  validates :name, presence: true
  validates :start_time, presence: true
  validates :image_name, presence: true


  def duration
    return nil unless finish_time && start_time

    return 0 if finish_time <= start_time

    finish_time - start_time
  end

  scope :completed, -> { where.not(finish_time: nil) }
end
