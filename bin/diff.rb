#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/comparison'

require 'pry'
diff = EveryPoliticianScraper::Comparison.new('data/wikidata.csv', 'data/official.csv').diff
                                         .reject { |row| row.last.to_s.include? "Secrétaire d'Etat" }
puts diff.sort_by { |r| [r.first, r[1].to_s] }.reverse.map(&:to_csv)
