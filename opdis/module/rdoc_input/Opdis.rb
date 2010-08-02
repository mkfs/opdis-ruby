#!/usr/bin/env ruby1.9
# :title: Opdis
=begin rdoc
=Opdis
<i>Copyright 2010 Thoughtgang <http://www.thoughtgang.org></i>

= Opdis Disassembler

== Summary

The Opdis Disassembler is a wrapper libopdis, which requires GNU binutils.
Currently the BFD gemis required.

== Example

  require 'BFD'
  require 'Opdis'

  o = Opdis.Disassembler.new() # Create disassembler

  Bfd::Target.new( filename ) do |tgt|
    # Control-flow disassembly from BFD entry point

    o.disassemble( tgt, strategy: o.STRATEGY_ENTRY ) do |i|
       # ... do something with instruction
    end

    # Control-flow disassembly from offset 0 in target
    insns = o.disassemble( t, strategy: o.STRATEGY_CFLOW, start: 0 )
    insn.each { |i| puts i }

    # Linear disassembly of 100 bytes starting at offset 0
    insns = o.disassemble( t, start: 0, len : 100 )
    insn.each { |i| puts i }

  end

  # disassemble the bytes 0x90 (nop) and 0xCC (int3)
  o.disassemble( [0x90, 0xCC] ) { |i| puts i } 

  # the same, using a string
  o.disassemble( "\x90\xCC" ) { |i| puts i } 

== Contact
Support:: community@thoughtgang.org
Project:: http://rubyforge.org/projects/opdis/
=end

module Opdis

=begin rdoc

=end
  class Disassembler

=begin rdoc
The object used to decode Instruction objects.

See Opdis::InstructionDecoder.
=end
    attr_accessor :insn_decoder

=begin rdoc
The object used to track visited addresses.

See Opdis::VisitedAddressTracker.
=end
    attr_accessor :addr_tracker

=begin rdoc
The object used to resolve instruction operands to VMAs.

See Opdis::AddressResolver.
=end
    attr_accessor :resolver

=begin rdoc
The debug flag for libopdis.
=end
    attr_accessor :debug

=begin rdoc
The syntax of the strings generated by libopcodes (AT&T or Intel).
=end
    attr_accessor :syntax

=begin rdoc
The architecture that targets will be disassembled for.
=end
    attr_accessor :arch

=begin rdoc
The <i>disassembler_options</i> field for libopcodes.
=end
    attr_accessor :opcodes_options

=begin rdoc
Disassemble a single instruction at the specified VMA.
=end
    STRATEGY_SINGLE='single'
=begin rdoc
Disassemble all instructions in buffer starting at the specified VMA. The
instructions are created by disassembling sequential memory addresses, with no 
regard to control flow.
=end
    STRATEGY_LINEAR='linear'
=begin rdoc
Disassemble instructions in a buffer starting at a given VMA (the entry point).
The algorithm recurses to follow the target operands of jump and call 
instructions, and returns when an unconditional jump or a return instruction 
is encountered.
=end
    STRATEGY_CFLOW='cflow'
=begin rdoc
Perform a control-flow disassembly using the specified BFD::Symbol object as
an entry point. Requires that the target be a Bfd::Symbol object.
=end
    STRATEGY_SYMBOL='bfd-symbol'
=begin rdoc
Perform a linear disassembly on the specified BFD::Section. Requires that the
target be a Bfd::Section object.
=end
    STRATEGY_SECTION='bfd-section'
=begin rdoc
Perform a control-flow disassembly on the specified BFD object using its
entry point (or <b>start_address</b>). Requires that the target be a 
Bfd::Target object.
=end
    STRATEGY_ENTRY='bfd-entry'

=begin rdoc
Available disassembler strategies.
=end
    STRATEGIES = [ STRATEGY_SINGLE, STRATEGY_LINEAR, STRATEGY_CFLOW,
                   STRATEGY_SYMBOL, STRATEGY_SECTION, STRATEGY_ENTRY ]

=begin rdoc
AT&T assembly language syntax (src, dest).
=end
    SYNTAX_ATT='att'
=begin rdoc
Intel assembly language syntax (dest, src).
=end
    SYNTAX_INTEL='intel'

=begin rdoc
=end
    SYNTAXES = [ SYNTAX_ATT, SYNTAX_INTEL ]

=begin rdoc
Disassemble all bytes in a target.

The target parameter can be a String of bytes, an Array of bytes, a 
Bfd::Target, a Bfd::Section, or a Bfd::Symbol.

The args parameter is a Hash which can contain any of the following members:

  resolver:: AddressResolver object to use instead of the builtin
             address resolver.

  addr_tracker:: VisitedAddressTracker object to use instead of the built-in 
                 address tracker.

  insn_decoder:: InstructionDecoder object to use instead of the built-in
                 instruction decoder.

  syntax:: Assembly language syntax to use; either SYNTAX_ATT (default) or
           SYNTAX_INTEL.

  debug:: Enable or disable libopdis debug mode.

  options:: Options command-line string for libopcodes. See disassembler_usage()
            in dis-asm.h for details.

  arch:: The architecture to disassemble for.

  strategy:: This disassembly algorithm to use. Default is STRATEGY_LINEAR.

  vma:: The VMA to start disassembly at. Default is 0.

  length:: The number of bytes to disassemble. Default is the entire buffer.

  buffer_vma:: The load address of the target. This is only needed when the
               target is a String or Array; BFD targets will provide their
               own VMAs. Default is 0.
=end
    def ext_disassemble(target, args) # :yields: instructions
    end

=begin rdoc
Instantiate a new Disassembler object.


The args parameter is a Hash which can contain any of the following members:

  resolver:: AddressResolver object to use instead of the builtin
             address resolver.

  addr_tracker:: VisitedAddressTracker object to use instead of the built-in 
                 address tracker.

  insn_decoder:: InstructionDecoder object to use instead of the built-in
                 instruction decoder.

  syntax:: Assembly language syntax to use; either SYNTAX_ATT (default) or
           SYNTAX_INTEL.

  debug:: Enable or disable libopdis debug mode.

  options:: Options command-line string for libopcodes. See disassembler_usage()
            in dis-asm.h for details.

  arch:: The architecture to disassemble for.
=end
    def initialize( args ) # :yields: disassembler
    end

=begin rdoc
Returns a list of all supported architectures.
=end
    def architectures()
    end
  end

=begin rdoc
Writes the output of disassembler_usage() in libopcodes to the supplied IO
object.
=end
    def ext_usage( io )
    end

=begin rdoc
Disassembler output.

This consists of a hash mapping VMA keys to Instruction objects. The Disassembly
object also contains an internal array of error messages generated by the
disassembler.
=end
  class Disassembly < Hash

=begin rdoc
An array of error messages encountered during disassembly.
=end
    attr_reader :errors

=begin rdoc
Returns the Instruction object containing VMA.
=end
    def containing(vma)
    end
  end

end
