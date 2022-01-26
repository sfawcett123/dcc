# frozen_string_literal: true

require 'net/http'

class Sketch
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :url

  validates :url, presence: true

  def persisted?
    false
  end

  class << self
    def all
      list_sketchs
    end

    private

    def logger
      Rails.logger
    end

    def repository
      Settings.sketchs.repository
    end

    def branch
      Settings.sketchs.branch
    end

    def directory
      Settings.sketchs.directory
    end

    def latest_uri
      URI("https://api.github.com/repos/#{repository}/git/trees/#{branch}?recursive=true")
    end

    def list_tree
      JSON.parse(Net::HTTP.get(latest_uri))['tree']
    end

    def list_sketchs
      list_tree.select { |n| n['path'].start_with?(directory.to_s) && n['type'] == 'tree' }
    end
  end
end
