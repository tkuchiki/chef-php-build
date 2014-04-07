git_action     = node[:php_build][:git_action]
git_revision   = node[:php_build][:git_revision]
install_dir    = "#{node[:php_build][:prefix]}/php-build"
prefix         = node[:php_build][:prefix]
php_build_repo = node[:php_build][:repository]

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
