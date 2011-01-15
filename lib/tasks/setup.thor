class Setup < Thor
  desc "symlinks [SHARED_DIR || '../../shared/config']", "Create symlinks for configuration files from shared directory"
  def symlinks(source_dir = "../../shared/config")
    source_dir = File.expand_path(source_dir)
    if Dir.exists?(source_dir)
      ["config.yml", "database.yml"].each do |file|
        source = File.join(source_dir, file)
        if File.exists?(source)
          FileUtils.cp(source, "config/#{file}")
        else
          puts "#{source} does not exist"
          exit(-1)
        end
      end
    else
      puts "#{source_dir} does not exist"
      exit(-1)
    end
  end
end