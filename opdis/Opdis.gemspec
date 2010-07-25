#!/usr/bin/env ruby1.9

require 'rubygems'
spec = Gem::Specification.new do |spec|
  spec.name = 'Opdis'
  spec.version = '1.0.0'
  spec.summary = 'Ruby extension library providing an API to libopdis'
  spec.description = %{Opdis is a disassembler based on the GNU binutils
  libopcodes disassembler. The strings generated by libopcodes are
  translated into Instruction and Operand objects, and disassembly
  algorithms such as linear and control-flow are provided.}

  spec.author = 'TG Community'
  spec.email = 'community@thoughtgang.org'
  spec.homepage = 'http://rubyforge.org/projects/opdis/'
  spec.rubyforge_project = 'opdis'

  spec.requirements = [ 'opdis library and headers',
                        'GNU binutils library and headers' ]

  spec.files = Dir['module/*.c', 'module/*.h']
  spec.extra_rdoc_files = Dir['module/rdoc_input/*.rb']
  spec.extensions = Dir['module/extconf.rb']
  spec.test_files = nil
end