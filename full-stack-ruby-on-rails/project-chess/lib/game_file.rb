# frozen_string_literal: true

require 'yaml'
require 'fileutils'

# A class to save/load an in-progress chess game to/from local disk
class GameFile
  DEFAULT_SAVE_LOCATION = './saves'
  DEFAULT_SAVE_FILE = 'saved.yml'
  PERMITTED_CLASSES = [
    Symbol,
    Player,
    Board,
    Rook,
    Knight,
    Bishop,
    Queen,
    King,
    Pawn
  ].freeze

  def initialize(save_directory = DEFAULT_SAVE_LOCATION, save_file = DEFAULT_SAVE_FILE)
    @save_directory = save_directory
    @save_file = save_file
    @save_path = "#{save_directory}/#{save_file}"
  end

  def save!(data)
    ensure_save_directory_exists

    save_file = File.open(@save_path, 'w')
    save_file.puts YAML.dump(data)
    save_file.close
    puts 'Game saved.'
  end

  def load!
    yaml = YAML.safe_load(File.open(@save_path), permitted_classes: PERMITTED_CLASSES, aliases: true)
    puts 'Previous game restored'
    yaml
  end

  def exists?
    File.exist? @save_path
  end

  def ensure_save_directory_exists
    FileUtils.mkdir_p @save_directory
  end
end
