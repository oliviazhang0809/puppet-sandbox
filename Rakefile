require 'puppet-lint/tasks/puppet-lint'

# see https://github.com/rodjek/puppet-lint/issues/331
Rake::Task[:lint].clear

PuppetLint::RakeTask.new :lint do |config|
  config.ignore_paths = ['modules/**/*.pp']
  config.log_format = "%{path}:%{linenumber}:%{check}:%{KIND}:%{message}"
  config.disable_checks = ['single_quote_string_with_variables', '80chars', 'class_inherits_from_params_class', 'variable_scope']
end