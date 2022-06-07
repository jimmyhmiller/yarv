# frozen_string_literal: true

module YARV
  # ### Summary
  #
  # `newhash` puts a new hash onto the stack, using `num` elements from the
  # stack. `num` needs to be even.
  #
  # ### TracePoint
  #
  # `newhash` does not dispatch any events.
  #
  # ### Usage
  #
  # ~~~ruby
  # def foo(key, value)
  #   { key => value }
  # end
  # ~~~
  #
  class NewHash < Insn
    attr_reader :size

    def initialize(size)
      @size = size
    end

    def ==(other)
      other in NewHash[size: ^(size)]
    end

    def call(context)
      key_values = context.stack.pop(size)
      context.stack.push(Hash[*key_values])
    end

    def deconstruct_keys(keys)
      { size: }
    end

    def disasm(iseq)
      "%-38s %s" % ["newhash", size]
    end
  end
end
