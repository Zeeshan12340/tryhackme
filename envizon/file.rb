#!/usr/bin/ruby
require 'hashids'

hashids = Hashids.new("Note", 30)
hash = hashids.encode(380)

puts hash
