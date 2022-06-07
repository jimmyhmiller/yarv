# frozen_string_literal: true

module YARV
  # ### Summary
  #
  # `getconstant` performs a constant lookup and pushes the value of the
  # constant onto the stack.
  #
  # ### TracePoint
  #
  # `getconstant` does not dispatch any events.
  #
  # ### Usage
  #
  # ~~~ruby
  # Constant
  # ~~~
  #
  class GetConstant < Insn
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def ==(other)
      other in GetConstant[name: ^(name)]
    end

    def call(context)
      klass, allow_nil = context.stack.pop(2)

      if klass.nil? && !allow_nil
        raise NameError, "uninitialized constant #{name}"
      end

      # At the moment we're just looking up constants in the parent runtime. In
      # the future, we'll want to look up constants in the YARV runtime as well.
      context.stack.push((klass || Object).const_get(name))
    end

    def deconstruct_keys(keys)
      { name: }
    end

    def disasm(iseq)
      "%-38s %s" % ["getconstant", name.inspect]
    end
  end
end
