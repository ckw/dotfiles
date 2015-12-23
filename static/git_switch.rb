#! /usr/bin/env ruby
# switch to the unique local branch that contains the argument string
# or switch to the remote branch that contains the argument string
# or print out the list of matches

def local(str)
  git_branch(str, false)
end

def remote(str)
  rms = git_branch(str, true)
  #how hacky is this
  rms.map{|r| r.strip.gsub(/^origin\/(.*)/,'\1')}
end

def git_branch(str, remote)
  rmt = remote ? "-r" : ""
  `git branch #{rmt}`.split("\n").keep_if{|s| s.include?(str) && !s.start_with?('*')} || []
end

def matches(str)
  local_ = local(str)
  return (local_.empty?) ? remote(str) : local_
end

def switch_to_match(str)
  ms = matches(str)

  ($stderr.puts('no matches'); exit 2) if ms.empty?

  if ms.length == 1
    `git checkout #{ms.first}`
    exit
  end

  $stderr.puts('found multiple matches')
  ms.each{|m| puts(m)}
  exit 3
end

($stderr.puts("usage: match_str <str>"); exit 1) unless ARGV.length == 1
switch_to_match(ARGV[0])
