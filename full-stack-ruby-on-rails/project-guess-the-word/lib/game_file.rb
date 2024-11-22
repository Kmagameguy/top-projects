class GameFile

  DEFAULT_SAVE_FILE = 'saved.yml'
  DEFAULT_SAVE_LOCATION = './saves'

  def initialize(data = {})
    puts 'Game saved.'

    ensure_save_directory_exists

    save_file = File.open("#{DEFAULT_SAVE_LOCATION}/#{DEFAULT_SAVE_FILE}", 'w')
    save_file.puts YAML.dump(data)
    save_file.close
  end

  def self.load
    puts 'Previous game restored.'
    YAML.safe_load(File.open("#{DEFAULT_SAVE_LOCATION}/#{DEFAULT_SAVE_FILE}"), permitted_classes: [Symbol])
  end

  private

  def ensure_save_directory_exists
    Dir.mkdir(DEFAULT_SAVE_LOCATION) unless Dir.exist?(DEFAULT_SAVE_LOCATION)
  end
end
