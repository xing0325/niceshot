#!/usr/bin/env ruby

require "fileutils"
require "json"
require "shellwords"
require "time"

RULE_DESCRIPTION = "NiceShot: Caps Lock Screenshot Layer"

project_root = File.expand_path("..", __dir__)
template_path = File.join(project_root, "karabiner", "rule.template.json")
config_path = File.expand_path(
  ENV.fetch("NICESHOT_CONFIG", "~/.config/karabiner/karabiner.json")
)
save_dir = File.expand_path(
  ENV.fetch("NICESHOT_SAVE_DIR", "~/Pictures/Screenshotschichu")
)

unless File.exist?("/Applications/Karabiner-Elements.app")
  abort <<~MESSAGE
    Karabiner-Elements is not installed.
    Install the free official release first:
    https://karabiner-elements.pqrs.org/
  MESSAGE
end

if save_dir.include?("\0") || save_dir.include?("\n")
  abort "NICESHOT_SAVE_DIR contains unsupported characters."
end

FileUtils.mkdir_p(File.dirname(config_path))
FileUtils.mkdir_p(save_dir)

configuration = if File.exist?(config_path)
                  JSON.parse(File.read(config_path))
                else
                  {
                    "profiles" => [
                      {
                        "complex_modifications" => { "rules" => [] },
                        "name" => "Default profile",
                        "selected" => true,
                        "virtual_hid_keyboard" => { "keyboard_type_v2" => "ansi" }
                      }
                    ]
                  }
                end

profiles = configuration["profiles"] ||= []
if profiles.empty?
  profiles << { "name" => "Default profile", "selected" => true }
end

profile = profiles.find { |candidate| candidate["selected"] } || profiles.first
complex_modifications = profile["complex_modifications"] ||= {}
rules = complex_modifications["rules"] ||= []

if rules.any? { |rule| rule["description"] == RULE_DESCRIPTION }
  puts "NiceShot is already installed in profile: #{profile['name']}"
  puts "Save directory: #{save_dir}"
  exit 0
end

baseline = JSON.pretty_generate(configuration) + "\n"
File.write(config_path, baseline) unless File.exist?(config_path)

backup_dir = File.join(File.dirname(config_path), "backups")
FileUtils.mkdir_p(backup_dir)
timestamp = Time.now.strftime("%Y%m%d-%H%M%S")
backup_path = File.join(backup_dir, "karabiner.before-niceshot.#{timestamp}.json")
FileUtils.cp(config_path, backup_path)

template_text = File.read(template_path).gsub(
  "__NICESHOT_SAVE_DIR_SHELL__",
  Shellwords.escape(save_dir)
)
rule = JSON.parse(template_text).fetch("rules").first
rules << rule

temporary_path = "#{config_path}.niceshot-#{Process.pid}.tmp"
File.write(temporary_path, JSON.pretty_generate(configuration) + "\n")
File.chmod(0o600, temporary_path)
File.rename(temporary_path, config_path)

puts "Installed NiceShot in profile: #{profile['name']}"
puts "Backup: #{backup_path}"
puts "Save directory: #{save_dir}"
