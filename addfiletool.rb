require 'xcodeproj'

class AddFileTool
  attr_reader :proj_path
  attr_reader :proj_obj

  def initialize(proj_path)
    @proj_path = proj_path
    @proj_obj = Xcodeproj::Project.open(proj_path)
  end

  def loger_var
    puts proj_path
    puts proj_obj
  end

  def add_build_file(file_path, group_name, target_name)
    # puts loger.proj_obj.main_group.groups
    target = proj_obj.targets.find { |e| e.name == target_name }
    to_add_group = proj_obj.groups.first.groups.find { |e| e.name == group_name }
    find_file_array = to_add_group.files.select { |e| e.real_path.to_s == file_path }
    find_file_array.each do |e|
      to_add_group.remove_reference(e)
    end
    to_add_group.new_reference(file_path, 1)
  end
end

loger = AddFileTool.new('/Users/sunyanguo/Documents/gitplace/InstallerPuts/InstallerPuts.xcodeproj')
to_add_path = '/Users/sunyanguo/Documents/gitplace/InstallerPuts/installer.methods'
loger.add_build_file(to_add_path, 'VC', 'InstallerPuts')
loger.proj_obj.save
loger.proj_obj.files.each { |e| puts e.path }

# loger.loger_var

# puts to_add_group.methods

# has subloger.proj_obj.groups.find { |e| e.groups }
# puts target.build_phases
# puts target.methods.select { |e| e.to_s.include?('build') }
