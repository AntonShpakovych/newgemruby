# frozen_string_literal: true

module Codebreaker
  class Statistics
    EMPTY_DATA = "Don't have data for store"
    BAD_FILE = "File doesn't exist or File doesn't have data"
    PERMITTED_CLASSES = [Codebreaker::User, Symbol].freeze
    YAML_OPTIONS = { permitted_classes: PERMITTED_CLASSES, aliases: true }.freeze

    def initialize(filename = 'default.yml')
      @filename = filename
      @data_to_store = []
    end

    def add_to_statistics(obj)
      @data_to_store.push(obj)
    end

    def save_unit
      @data_to_store.empty? ? raise(StandardError, EMPTY_DATA) : File.write(@filename, @data_to_store.to_yaml)
    end

    def show
      create_table(validate_file ? YAML.load_file(@filename, **YAML_OPTIONS) : raise(StandardError, BAD_FILE))
    end

    def sort_store(data)
      sort_attemps_hints = data.sort_by { |hints| hints[:hints_used] }.sort_by { |attempts| attempts[:attempts_used] }
      sort_attemps_hints.sort_by { |difficulty| difficulty[:hints_total] && difficulty[:attempts_total] }
    end

    def create_table(data)
      data_for_table = sort_store(data)
      data_for_table.map.with_index do |item_store, index|
        "RATING:#{index + 1} NAME:#{item_store[:user].name} DIFFICULTY:#{item_store[:difficulty]}"\
          " ATTEMPTS_TOTAL:#{item_store[:attempts_total]} ATTEMPTS_USED:#{item_store[:attempts_used]}"\
          " HINTS_TOTAL:#{item_store[:hints_total]} HINTS_USED:#{item_store[:hints_used]}"
      end
    end

    private

    def validate_file
      File.exist?(@filename) && !File.zero?(@filename)
    end
  end
end
