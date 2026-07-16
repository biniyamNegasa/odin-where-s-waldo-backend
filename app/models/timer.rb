class Timer < ApplicationRecord
  CHARACTERS = %w[waldo wenda wizard odlaw].freeze
  USERNAME_FORMAT = /\A[a-zA-Z][a-zA-Z0-9]{2,19}\z/

  validates :name, presence: true,
    format: { with: USERNAME_FORMAT,
              message: "must be 3-20 characters, start with a letter, and contain only letters or numbers" }
  validates :start_time, presence: true
  validates :image_name, presence: true
  validate :image_must_exist

  scope :completed, -> { where.not(finish_time: nil) }
  scope :abandoned, ->(age = 24.hours) { where(finish_time: nil).where(created_at: ...age.ago) }

  def duration
    return nil unless finish_time && start_time

    return 0 if finish_time <= start_time

    (finish_time - start_time).round(2)
  end

  def record_found(character)
    return if found_characters.include?(character)

    update!(found_characters: found_characters + [ character ])
  end

  def all_found?
    (CHARACTERS - found_characters).empty?
  end

  def finished?
    finish_time.present?
  end

  private

  def image_must_exist
    return if image_name.blank?

    unless ImageCoordinate.exists?(name: image_name)
      errors.add(:image_name, "is not a known image")
    end
  end
end
