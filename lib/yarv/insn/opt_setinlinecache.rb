# frozen_string_literal: true

module YARV
  # ### Summary
  #
  # `opt_setinlinecache` is the final instruction after a series of
  # `getconstant` instructions that populates the inline cache associated with
  # an `opt_getinlinecache` instruction.
  #
  # ### TracePoint
  #
  # `opt_setinlinecache` does not dispatch any events.
  #
  # ### Usage
  #
  # ~~~ruby
  # Constant
  # ~~~
  #
  class OptSetInlineCache < Insn
    attr_reader :cache

    def initialize(cache)
      @cache = cache
    end

    def ==(other)
      other in OptSetInlineCache[cache: ^(cache)]
    end

    def call(context)
      # Since we're not actually populating inline caches in YARV, we don't need
      # to do anything in this instruction.
    end

    def deconstruct_keys(keys)
      { cache: }
    end

    def disasm(iseq)
      "%-38s <is:%d>" % ["opt_setinlinecache", cache]
    end
  end
end
