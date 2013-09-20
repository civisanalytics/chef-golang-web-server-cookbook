define :nutty_deploy_dir do
  # create shared/ directory structure
  ['log','config','system','pids','scripts','sockets'].each do |dir_name|
    directory "#{params[:path]}/shared/#{dir_name}" do
      group params[:group]
      owner params[:user]
      mode 0770
      action :create
      recursive true
    end
  end

  #symlink to goroot
  src_base = "#{node['go']['install_dir']}/go/src/pkg"
  if params[:import_path] and !File.exists?("#{src_base}/#{params[:import_path]}")
    dir_parts = params[:import_path].split("/")
    import_base = dir_parts[0, dir_parts.length-1]
    link_dir = dir_parts[-1]

    directory "#{src_base}/#{import_base}" do 
      action :create
      group params[:group]
      owner params[:user]
      mode 0770
      recursive true
    end

  end

end
