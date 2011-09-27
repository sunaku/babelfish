require 'rake/clean'

##
# documentation
#

desc "Build the documentation."
task :doc

# user manual
task :doc => 'index.html'

file 'index.html' => 'README.md' do |t|
  sh 'maruku', t.prerequisites[0], '-o', t.name
end

CLOBBER.include 'index.html'

# API reference
task :doc => 'api'

require 'rake/rdoctask'
Rake::RDocTask.new 'api' do |t|
  t.rdoc_dir = t.name
  t.rdoc_files.exclude('pkg').include('**/*.rb')
end


##
# packaging
#

require 'rake/gempackagetask'
require 'lib/babelfish' # project info

spec = Gem::Specification.new do |s|
  s.rubyforge_project = 'sunaku'
  s.author, s.email   = File.read('LICENSE').
                        scan(/Copyright \d+ (.*) <(.*?)>/).first

  s.name              = BabelFish::PROJECT
  s.version           = BabelFish::VERSION
  s.summary           = BabelFish::SUMMARY
  s.description       = s.summary
  s.homepage          = BabelFish::WEBSITE
  s.files             = FileList['**/*']
  s.executables       = s.name
  s.has_rdoc          = true

  # gems needed by the command line interface
  s.add_dependency 'trollop', '~> 1.10'

  # gems needed by the ruby library
  s.add_dependency 'hpricot', '~> 0.6'
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_tar = true
  pkg.need_zip = true
end

desc 'Build release packages.'
task :pack => [:clobber, :doc] do
  sh $0, 'package'
end


##
# releasing
#

desc 'Upload to project website.'
task :website => :doc do
  sh "rsync -av index.html api ~/www/lib/#{spec.name} --delete"
end

desc 'Publish release packages.'
task :publish => :pack do
  sh 'rubyforge', 'login'

  pusher = lambda do |cmd, pkg|
    sh 'rubyforge', cmd, '--release_date', BabelFish::RELEASE,
        spec.rubyforge_project, spec.name, spec.version.to_s, pkg
  end

  packs = Dir['pkg/*.[a-z]*']

  # push ONLY the first package using 'add_release'.  otherwise, we
  # get one package per sub-section on the RubyForge download page!
  pusher['add_release', packs.shift]
  packs.each {|pkg| pusher['add_file', pkg] }
end
