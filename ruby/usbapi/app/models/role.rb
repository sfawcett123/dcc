# frozen_string_literal: true

class Role < ApplicationRecord
  cattr_accessor :form_steps do
    %w[name_role]
  end

  attr_accessor :form_step

  validates :name, presence: true, if: -> { required_for_step?(:name_role) }

  private

  def required_for_step?(step)
    return true if form_step.nil?
    return true if form_steps.index(step.to_s) <= form_steps.index(form_step)
  end

  class << self
    def attributes_for_step(step)
      case step
      when 'name_role'
        %i[name path]
      end
    end
  end
end
