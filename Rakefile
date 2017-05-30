require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "set_1"
  t.libs << "tests"
  t.test_files = FileList['tests/**/*_test.rb']
end

desc "Run Tests"
task default: :test
