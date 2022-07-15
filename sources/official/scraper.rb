#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    def name
      Name.new(
        full: full_name,
        prefixes: %w[Monsieur Madame Dr.],
      ).short
    end

    def position
      noko.css('.minister-fonc').text.tidy
    end

    field :gender do
      return 'male' if full_name.start_with? 'Monsieur'
      return 'female' if full_name.start_with? 'Madame'
    end

    private

    def full_name
      noko.css('.minister-name').text.tidy
    end

  end

  class Members
    def member_container
      noko.css('.view__content').first.css('.views-row')
    end
  end
end

file = Pathname.new 'official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
