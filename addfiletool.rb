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
    # 找到target
    target = proj_obj.targets.find { |e| e.name == target_name }
    # 找到group_name所在的group，用的[]方式找，找到后再调用[group_name]，就拿到了要添加文件的group
    to_add_group = (proj_obj.groups.find { |e| e[group_name]})[group_name]
    # 找到所有的real_path是file_path的，select方法返回的是数组
    find_file_array = to_add_group.files.select { |e| e.real_path.to_s == file_path }
    # 对所有的已经在工程里的文件，进行remove操作，保证不重复添加
    find_file_array.each do |e|
      to_add_group.remove_reference(e)
    end
    # 找到build_phase
    build_phase = target.build_phases.find { |e| e.is_a?(Xcodeproj::Project::Object::PBXSourcesBuildPhase)}
    # 在build_phase里添加文件的同时，把文件加到对应的group里面
    build_phase.add_file_reference(to_add_group.new_reference(file_path))
  end
end

loger = AddFileTool.new('/Users/sunyanguo/Documents/gitplace/InstallerPuts/InstallerPuts.xcodeproj')
to_add_path = '/Users/sunyanguo/Documents/gitplace/InstallerPuts/installer2.yaml'
loger.add_build_file(to_add_path, 'VC', 'InstallerPuts')
loger.proj_obj.save

