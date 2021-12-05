#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    def name
      name_with_position.first
    end

    def position
      position_as_next_node.empty? ? name_with_position[1] : position_as_next_node
    end

    private

    def name_node
      noko.css('div.h4')
    end

    # sometimes the name field also includes the position
    def name_with_position
      name_node.text.tidy.split(/, (?=Minister)/)
    end

    def position_as_next_node
      name_node.xpath('following-sibling::div').text.tidy
    end
  end

  class Members
    def member_container
      noko.css('article ul li')
    end
  end
end

file = Pathname.new 'html/official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
