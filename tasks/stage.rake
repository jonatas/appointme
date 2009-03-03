desc 'Generate stage project files'
task :stage => :ruby_env do
  Dir['stage_pt_br/*.txt'].each do |txt|
    html_file = txt.gsub(/txt$/,'html')
    sh %{ #{RUBY_APP} script/txt2html #{txt} > #{html_file} }
    sh %{ open #{html_file}} 
  end
end

desc 'Upload website files to rubyforge'
task :stage_upload do
  host = "#{rubyforge_username}@rubyforge.org"
  remote_dir = "/var/www/gforge-projects/#{PATH}/"
  local_dir = 'website'
  sh %{rsync -aCv #{local_dir}/ #{host}:#{remote_dir}}
end

desc 'Generate and upload website files'
task :website => [:website_generate, :website_upload, :publish_docs]
