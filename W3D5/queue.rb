# Now let's write a Queue class. We will need the following instance methods: enqueue(el), dequeue, and peek.

# Test your code to ensure it follows the principle of FIFO.

class Queue

    attr_reader :queue

    def initialize
        @queue = Array.new
    end

    def enqueue(el)
        queue.unshift(el)
    end
    
    def dequeue
        queue.pop
    end 
    
    def peek
        queue.first
    end

    def empty?
        queue.length == 0
    end

    def show
        queue.dup
    end

end

# queue = Queue.new
# queue.enqueue(1)
# queue.enqueue(2)
# queue.enqueue(3)
# queue.enqueue(4)
# queue.enqueue(5)
# queue.peek
