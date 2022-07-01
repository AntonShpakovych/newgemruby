# frozen_string_literal: true

module Codebreaker
  class Statistics
    include Constants::Shared

    attr_reader :filename

    FILENAME = 'default.yml'

    def initialize(filename = FILENAME)
      @filename = filename
      @data_store = []
    end

    def add_to_data_store(game)
      @data_store.push(data_to_save(game))
    end

    def save_unit
      raise(StandardError, I18n.t(:empty_data)) if @data_store.empty?

      data_save = @data_store.to_yaml
      data_save.slice!('---')

      File.open(@filename, 'a') do |f|
        f.write(data_save)
      end
    end

    def show
      file_valid? ? sort_store(YAML.load_file(@filename)) : raise(StandardError, I18n.t(:bad_file))
    end

    private

    def sort_store(data)
      sort_attemps_hints = data.sort_by { |hints| hints[:hints_used] }.sort_by { |attempts| attempts[:attempts_used] }
      sort_attemps_hints.sort_by { |difficulty| difficulty[:hints_total] && difficulty[:attempts_total] }
    end

    def file_valid?
      File.exist?(@filename) && !File.zero?(@filename)
    end

    def total_attempts(type)
      TYPE_OF_DIFFICULTY[type][:attempts]
    end

    def total_hints(type)
      TYPE_OF_DIFFICULTY[type][:hints]
    end

    def data_to_save(game)
      { user: game.user,
        difficulty: game.type,
        attempts_total: total_attempts(game.type),
        attempts_used: total_attempts(game.type) - game.attempts,
        hints_total: total_hints(game.type),
        hints_used: total_hints(game.type) - game.hints }
    end
  end
end
