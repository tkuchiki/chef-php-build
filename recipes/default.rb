git_action      = node[:php_build][:git_action]
git_revision    = node[:php_build][:git_revision]
prefix          = node[:php_build][:prefix]
install_dir     = "#{prefix}/php-build"
php_build_repo  = node[:php_build][:repository]
config_dir      = node[:php_build][:config_dir]
default_options = "#{config_dir}/default_configure_options"

git install_dir do
  action     git_action.to_sym
  repository php_build_repo
  revision   git_revision
end

bash "exec install.sh" do
  cwd  install_dir
  code <<EOC
    PREFIX="#{prefix}" ./install.sh
EOC

  not_if "which php-build"
end

template default_options do
  source "default_configure_options.erb"
end
