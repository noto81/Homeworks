class Stack
  
  attr_reader :stack

    def initialize
      # create ivar to store stack here!
      @stack = Array.new
    end

    def push(el)
      # adds an element to the stack
       stack.push(el)
    end

    def pop
      # removes one element from the stack
      stack.pop
    end

    def peek
      # returns, but doesn't remove, the top element in the stack
      stack.last
    end

  end

  # stack = Stack.new

#   [12] pry(main)> stack.push(2)
# => [2]
# [13] pry(main)> stack.push(7)
# => [2, 7]
# [14] pry(main)> stack.peek
# => 7
