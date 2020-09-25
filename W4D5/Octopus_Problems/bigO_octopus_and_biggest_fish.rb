# Sluggish Octopus
# Find the longest fish in O(n^2) time. 
# Do this by comparing all fish lengths to all other fish lengths

# ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']
# => "fiiiissshhhhhh"

def sluggish_octopus(fishes)
  biggest_fish = ""

  fishes.each_with_index do |fish1, idx1|
    fishes.each_with_index do |fish2, idx2|
        if idx2 > idx1
            if fish2.length > biggest_fish.length
                biggest_fish << fish2
            end
        end
    end
  end
  return biggest_fish
end

p sluggish_octopus(['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh'])

# => "fiiiissshhhhhh"


# Dominant Octopus
# Find the longest fish in O(n log n) time. 
# Hint: You saw a sorting algorithm that runs in O(n log n) in the Sorting Complexity Demo. 
# Remember that Big O is classified by the dominant term.

class Array
    
    def merge_sort(&prc)
      prc ||= Proc.new { |x, y| x <=> y }
  
      return self if count <= 1
  
      midpoint = count / 2
      sorted_left = self.take(midpoint).merge_sort(&prc)
      sorted_right = self.drop(midpoint).merge_sort(&prc)
  
      Array.merge(sorted_left, sorted_right, &prc)
    end
  
    private
    def self.merge(left, right, &prc)
      merged = []
  
      until left.empty? || right.empty?
        case prc.call(left.first, right.first)
        when -1
          merged << left.shift
        when 0
          merged << left.shift
        when 1
          merged << right.shift
        end
      end
  
      merged.concat(left)
      merged.concat(right)
  
      merged
    end
  end

  def dominant_octopus(fishes)
    # sort the array longest to shortest
    prc = Proc.new { |x, y| y.length <=> x.length }
    #return the first element
    fishes.merge_sort(&prc)[0]
  end

 # fishes = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']
 # dominant_octopus(fishes)



# Clever Octopus
# Find the longest fish in O(n) time. 
# The octopus can hold on to the longest fish that you have found so far while stepping through the array only once.

def clever_octopus(fishes)
    biggest_fish = fishes.first
  
    fishes.each do |fish|
      if fish.length > biggest_fish.length
         biggest_fish = fish
      end
    end
  
    biggest_fish
  
  end

# fishes = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']
 # clever_octopus(fishes)

# Dancing Octopus
# Full of fish, the Octopus attempts Dance Dance Revolution. 
# The game has tiles in the following directions:
# tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]
# To play the game, the octopus must step on a tile with her corresponding tentacle. 
# We can assume that the octopus's eight tentacles are numbered and correspond to the tile direction indices.

# Slow Dance
# Given a tile direction, iterate through a tiles array to return the tentacle number (tile index) the octopus must move. 
# This should take O(n) time.


def slow_dance(direction, tiles_array)
    tiles_array.each_with_index do |tile, index|
      return index if tile == direction
    end
  end

# slow_dance("up", tiles_array) => 0
# slow_dance("right-down", tiles_array) => 3


#   Constant Dance! O(1)
#   Now that the octopus is warmed up, let's help her dance faster. 
#   Use a different data structure and write a new function so that you can access the tentacle number in O(1) time.
  

  tiles_hash = {
      "up" => 0,
      "right-up" => 1,
      "right"=> 2,
      "right-down" => 3,
      "down" => 4,
      "left-down" => 5,
      "left" => 6,
      "left-up" => 7
  }
  
  def fast_dance(direction, tiles_hash)
    tiles_hash[direction]
  end

#   fast_dance("up", new_tiles_data_structure) => 0
#   fast_dance("right-down", new_tiles_data_structure) => 3

  