#! /usr/bin/env ruby

usage = "usage: uuids [-h,--help] [-u, --unique]"

a = '[a-zA-Z0-9]'
uuidReg = "#{a}{8}-#{a}{4}-#{a}{4}-#{a}{4}-#{a}{12}"

help = ARGV.delete('--help') || ARGV.delete('-h')
check_unique = ARGV.delete('--unique') || ARGV.delete('-u')

if help || ARGV.length > 0
  puts usage
  exit 1
end

if check_unique
  uuids = `ack-grep -h -o #{uuidReg}`.split("\n")
  dups = uuids.group_by{ |e| e }.select { |k, v| v.size > 1 }.map(&:first)
  dups.empty? ? (exit;) : (dups.each{|u| puts u}; exit 1)
end

puts `ack-grep '#{uuidReg}'`
