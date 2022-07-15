#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    def name
      noko.css('.views-field-title').text.tidy
    end

    def position
      noko.css('.views-field-field-fonction-du-ministre').text.tidy
    end
  end

  class Members
    def member_container
      noko.css('.view-content').first.css('.views-row')
    end
  end
end

file = Pathname.new 'official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
