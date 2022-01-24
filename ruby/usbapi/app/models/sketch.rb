require 'net/http'

class Sketch

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :url  

  validates :url, :presence => true

  def persisted?
    false
  end







  class << self
    def all
      return list_sketchs
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
      return JSON.parse( Net::HTTP.get(latest_uri) )['tree']
    end 

    def list_sketchs
      return list_tree.select { |n|  n["path"].start_with?( "#{directory}" ) && n["type"] == "tree"}
    end 
  end 

end
