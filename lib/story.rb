#code goes here
require 'pry'
require 'json'

class Story
  attr_reader :section,
              :subsection,
              :title,
              :abstract,
              :link,
              :published,
              :photo


	def initialize(cont)
		@section = cont[:section]
		@subsection = cont[:subsection]
		@title = cont[:title]
		@abstract = cont[:abstract]
		@link = cont[:link]
		@published = cont[:published]
		@photo = cont[:photo]
	end

	def self.create_cont
		file = File.read('./data/nytimes.json')
		data_params = JSON.parse(file, :symbolize_names => true)[:results]

    story_data = data_params.map do |data|
      if data_params[0][:multimedia][2][:format] == "Normal"
        {
        section: data[:section],
        subsection: data[:subsection],
        title: data[:title],
        abstract: data[:abstract],
        link: data[:url],
        pulished: data[:published_data],
        photo: data[:multimedia][2][:url]
        }
      else
        {
        section: data[:section],
        subsection: data[:subsection],
        title: data[:title],
        abstract: data[:abstract],
        link: data[:url],
        pulished: data[:published_data],
        photo: "No Photo Available"
        }
      end
    end

    story_data.map do |story_hash|
      Story.new(story_hash)
    end
	end
end
