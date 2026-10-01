#!/usr/bin/env ruby

require "fileutils"
require "json"
require "time"

RULE_DESCRIPTION = "NiceShot: Caps Lock Screenshot Layer"

config_path = File.expand_path(
  ENV.fetch("NICESHOT_CONFIG", "~/.config/karabiner/karabiner.json")
)

abort "Karabiner configuration not found: #{config_path}" unless File.exist?(config_path)

configuration = JSON.parse(File.read(config_path))
removed = 0

Array(configuration["profiles"]).each do |profile|
  rules = profile.dig("complex_modifications", "rules")
  next unless rules.is_a?(Array)

  before = rules.length
  rules.reject! { |rule| rule["description"] == RULE_DESCRIPTION }
  removed += before - rules.length
end

if removed.zero?
  puts "NiceShot rule was not present. No changes made."
  exit 0
end

backup_dir = File.join(File.dirname(config_path), "backups")
FileUtils.mkdir_p(backup_dir)
timestamp = Time.now.strftime("%Y%m%d-%H%M%S")
backup_path = File.join(backup_dir, "karabiner.before-niceshot-uninstall.#{timestamp}.json")
FileUtils.cp(config_path, backup_path)

temporary_path = "#{config_path}.niceshot-#{Process.pid}.tmp"
File.write(temporary_path, JSON.pretty_generate(configuration) + "\n")
File.chmod(0o600, temporary_path)
File.rename(temporary_path, config_path)

puts "Removed #{removed} NiceShot rule(s)."
puts "Backup: #{backup_path}"

