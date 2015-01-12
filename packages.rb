Ohai.plugin(:Packages) do
  provides 'packages'
  depends 'platform_family'

cmdlines = [
  { "platform" => "debian", "pkgs_cmd" => "dpkg-query -W -f='${Package}: ${Version}\n'", "updts_repo" => "apt-get update", "updts_cmd" => "apt-get -s upgrade | awk '/^Inst/{gsub(/\\(/,\"\",$0); print $2\": \"$4}'" },
  { "platform" => "rhel", "pkgs_cmd" => "rpm -qa --queryformat '%{NAME}: %{VERSION}-%{RELEASE}\n'", "updts_repo" => "yum update", "updts_cmd" => "yum -q list updates | awk 'NR>1{gsub(/(\\..+)/, \"\",$1); print $1\": \"$2}'" },
  { "platform" => "suse", "pkgs_cmd" => "rpm -qa --queryformat '%{NAME}: %{VERSION}-%{RELEASE}\n'", "updts_repo" => "zypper refresh", "updts_cmd" => "zypper list-updates --all | awk -F'|' '/^v/{gsub(/ /, \"\", $0); print $3\": \"$5}'" }
]

  collect_data(:linux) do
    packages Array.new

    so_pkg = shell_out(cmdlines.find { |plt| plt['platform'] == platform_family }['pkgs_cmd'])
    pkgs = so_pkg.stdout.split("\n")
    pkgs.each do |pkg|
      pkg = pkg.split(": ")
      packages.push(:name => pkg[0], :version => pkg[1])
   end

   shell_out(cmdlines.find{ |plt| plt['platform'] == platform_family }['updts_repo'])

   so_upd = shell_out(cmdlines.find { |plt| plt['platform'] == platform_family }['updts_cmd'])
   updates = so_upd.stdout.split("\n")
   updates.each do |update|
     update = update.split(': ')
     packages.find { |pkg| pkg[:name] == update[0] }[:update] = update[1]
   end
  end
end
