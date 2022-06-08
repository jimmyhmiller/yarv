# frozen_string_literal: true

module YARV
  # ### Summary
  #
  # `putobject_INT2FIX_1_` pushes 1 on the stack.
  # It is a specialized instruction resulting from the operand
  # unification optimization. It is the equivalent to `putobject 1`.
  #
  # ### TracePoint
  #
  # `putobject` can dispatch the line event.
  #
  # ### Usage
  #
  # ~~~ruby
  # 1
  # ~~~
  #
  class PutObjectInt2Fix1 < Instruction
    def ==(other)
      other in PutObjectInt2Fix1
    end

    def call(context)
      context.stack.push(1)
    end

    def disasm(iseq)
      "putobject_INT2FIX_1_"
    end
  end
end
