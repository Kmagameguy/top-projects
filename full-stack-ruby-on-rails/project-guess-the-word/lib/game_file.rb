class GameFile

  DEFAULT_SAVE_FILE = 'saved.yml'

  def initialize(data = {})
    puts 'Game saved.'

    save_file = File.open(DEFAULT_SAVE_FILE, 'w')
    save_file.puts YAML.dump(data)
    save_file.close
  end

  def self.load
    puts 'Previous game restored.'
    YAML.safe_load(File.open(DEFAULT_SAVE_FILE), permitted_classes: [Symbol])
  end
end
