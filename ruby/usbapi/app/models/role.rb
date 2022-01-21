# frozen_string_literal: true

class Role < ApplicationRecord
  cattr_accessor :form_steps do
    %w(name_role sketch_source)
  end

end
