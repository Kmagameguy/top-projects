# frozen_string_literal: true

require 'yaml'
require 'fileutils'

# This class serializes & deserializes game data to YAML on disk
class GameFile
  DEFAULT_SAVE_LOCATION = './saves'
  DEFAULT_SAVE_FILE = 'saved.yml'

  def initialize(data = {}, save_directory = DEFAULT_SAVE_LOCATION, save_file = DEFAULT_SAVE_FILE)
    @data = data
    @save_directory = save_directory
    @save_file = save_file
    @save_path = "#{save_directory}/#{save_file}"
    create_or_overwrite_file
  end

  def self.load(save_directory = DEFAULT_SAVE_LOCATION, save_file = DEFAULT_SAVE_FILE)
    path = "#{save_directory}/#{save_file}"
    puts 'Previous game restored.'
    YAML.safe_load(File.open(path), permitted_classes: [Symbol])
  end

  def self.save_exists?(save_directory = DEFAULT_SAVE_LOCATION, save_file = DEFAULT_SAVE_FILE)
    path = "#{save_directory}/#{save_file}"
    File.exist?(path)
  end

  private

  def create_or_overwrite_file
    ensure_save_directory_exists

    save_file = File.open(@save_path, 'w')
    save_file.puts YAML.dump(@data)
    save_file.close
    puts 'Game saved.'
  end

  def ensure_save_directory_exists
    FileUtils.mkdir_p @save_directory
  end
end
