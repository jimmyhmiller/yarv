module YARV
  # ### Summary
  #
  # `setn` is an instruction for set Nth stack entry to stack top
  #
  # ### TracePoint
  #
  #  # `setn` does not dispatch any events.
  #
  # ### Usage
  #
  # ~~~ruby
  # {}[:key] = 'val'
  # ~~~
  #
  class SetN < Insn
    attr_reader :index

    def initialize(index)
      @index = index
    end

    def ==(other)
      other in SetN[index: ^(index)]
    end

    def call(context)
      context.stack[-index - 1] = context.stack.last
    end

    def deconstruct_keys(keys)
      { index: }
    end

    def disasm(iseq)
      "%-38s %s" % ["setn", index]
    end
  end
end
