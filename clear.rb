require 'fileutils'

class Clear
  def initialize(run, path)
    if run == 'run'
      dirs = Dir.new(path)
      date_before_6_day = (Time.now - 86400 * 6).strftime('%Y-%m-%d')

      dirs.each do |dir|
        # p dir
        next if dir =~ /^\.\.?$/
        if File.directory?("#{path}#{dir}")
          ndirs = Dir.new("#{path}#{dir}")
          ndirs.each do |ndir|
            next if ndir =~ /^\.\.?$/
            # p "#{dir}/#{ndir}"
            if ndir == date_before_6_day
              # p "remove #{path}#{dir}/#{ndir}"
              FileUtils.rm_r("#{path}#{dir}/#{ndir}")
            end
          end
        end
      end
    end
  end
end
