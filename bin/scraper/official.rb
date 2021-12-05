#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    def name
      name_node.text.tidy
    end

    def position
      name_node.xpath('following-sibling::div').text.tidy
    end

    private

    def name_node
      noko.css('div.h4')
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
