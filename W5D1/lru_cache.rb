 class LRUCache

    def initialize(size)
        @size = size
        @cache = []
      end

    def count
      # returns number of elements currently in cache
      @cache.count
    end

    def add(el)
      # adds element to cache according to LRU principle
      if @cache.include?(el)
        @cache.delete(el)
        @cache << el
      elsif count >= @size
        @cache.shift
        @cache << el
      else
        @cache << el
      end
    end

    def show
      # shows the items in the cache, with the LRU item first
      p @cache
     
    end

    private
    # helper methods go here!

  end


#   johnny_cache = LRUCache.new(4)
#   johnny_cache.add("I walk the line")
#   johnny_cache.add(5)
#   johnny_cache.count # => returns 2
#   johnny_cache.add([1,2,3])
#   johnny_cache.add(5)
#   johnny_cache.add(-5)
#   johnny_cache.add({a: 1, b: 2, c: 3})
#   johnny_cache.add([1,2,3,4])
#   johnny_cache.add("I walk the line")
#   johnny_cache.add(:ring_of_fire)
#   johnny_cache.add("I walk the line")
#   johnny_cache.add({a: 1, b: 2, c: 3})
#   johnny_cache.show # => prints [[1, 2, 3, 4], :ring_of_fire, "I walk the line", {:a=>1, :b=>2, :c=>3}]

# [22] pry(main)> johnny_cache = LRUCache.new(4)      
# => #<LRUCache:0x00007fffc308bbf8 @cache=[], @size=4>
# [23] pry(main)> johnny_cache.add("I walk the line")
# => ["I walk the line"]
# [24] pry(main)> johnny_cache.add(5)  
# => ["I walk the line", 5]
# [25] pry(main)> johnny_cache.count # => returns 2  
# => 2
# [26] pry(main)> johnny_cache.add([1,2,3])
# => ["I walk the line", 5, [1, 2, 3]]
# [27] pry(main)> johnny_cache.add(5)
# => ["I walk the line", [1, 2, 3], 5]
# [28] pry(main)> johnny_cache.add(-5)
# => ["I walk the line", [1, 2, 3], 5, -5]
# [29] pry(main)> johnny_cache.add({a: 1, b: 2, c: 3})
# => [[1, 2, 3], 5, -5, {:a=>1, :b=>2, :c=>3}]
# [30] pry(main)> johnny_cache.add([1,2,3,4])
# => [5, -5, {:a=>1, :b=>2, :c=>3}, [1, 2, 3, 4]]
# [31] pry(main)> johnny_cache.add("I walk the line")
# => [-5, {:a=>1, :b=>2, :c=>3}, [1, 2, 3, 4], "I walk the line"]
# [32] pry(main)> johnny_cache.add(:ring_of_fire)
# => [{:a=>1, :b=>2, :c=>3}, [1, 2, 3, 4], "I walk the line", :ring_of_fire]
# [33] pry(main)> johnny_cache.add("I walk the line")
# => [{:a=>1, :b=>2, :c=>3}, [1, 2, 3, 4], :ring_of_fire, "I walk the line"]
# [34] pry(main)> johnny_cache.add({a: 1, b: 2, c: 3})
# => [[1, 2, 3, 4], :ring_of_fire, "I walk the line", {:a=>1, :b=>2, :c=>3}]
# [35] pry(main)>
# [36] pry(main)> johnny_cache.show
# [[1, 2, 3, 4], :ring_of_fire, "I walk the line", {:a=>1, :b=>2, :c=>3}]
# => [[1, 2, 3, 4], :ring_of_fire, "I walk the line", {:a=>1, :b=>2, :c=>3}]