def each_starts_with(str_arr, start)
	str_arr.each do |str|
		if str.start_with?(start)
			yield(str)
		end
	end
end

array = ["arbnb", "facebook", "a9", "audacity", "array"]
start = "ar"
each_starts_with(array, start) do |s|  puts s end

puts "\n"

each_starts_with(["abcd", "axyz", "able", "xyzab", "qrst"], "ab") {|s| puts s+s}

class Numeric
    def squared()
        return self*self
    end
end

puts 9.squared
puts 16.squared

def funny_sort(str_array)
    
    str_array.sort do |x,y|
        digit_x = x.scan(/\d+/).first
        digit_y = y.scan(/\d+/).first
        if digit_x==nil then digit_x = -1 end
        if digit_y==nil then digit_y = -1 end
        Integer(digit_x) <=> Integer(digit_y)
    end
    
end

puts funny_sort(["-100x500","abc99.6", "not a number", "tc130", "giants"])

module Enumerable
    def each_group_by_first_char()
        sorted_words = self.sort
        cur_start = sorted_words[0][0]
        return_words = []
        for word in sorted_words
            if word[0]==cur_start
                return_words.push(word)
                else
                yield(cur_start,return_words)
                cur_start = word[0]
                return_words = [word]
            end
        end
        yield(cur_start,return_words)
    end
end


x = ["abcd", "axyz", "able", "xyzab", "qrst"]

x.each_group_by_first_char do |char, words|
    printf("%s: %s\n", char, words.join(" "));
end

def filter(num_arr, options={})
    
    min = options[:min]
    max = options[:max]
    odd = options[:odd]
    even = options[:even]
    scale = options[:scale]
    
    num_arr.each do |num|
        if min!=nil&&num<min
            next
            elsif max!=nil&&num>max
            next
            elsif odd!=nil&&num%2==0
            next
            elsif even!=nil&&num%2==1
            next
            elsif scale!=nil
            num*=scale
        end
        yield(num)
    end
end


nums = [6, -5, 319, 400, 18, 94, 11]
filter(nums, :min => 10, :max => 350, :odd => 1, :scale => 2) {|n| puts n}
puts "\n"
filter(nums, :max => 0) {|n| puts n}
puts "\n"
filter(nums) {|n| puts n}


class Adder
    def initialize(add_num)
        @add_num = add_num
    end
    
    def method_missing(name_arg, *argu)
        name = name_arg.to_s
        if name[0..3]=="plus" && /\d+/===name[4..-1]
            num = name[4..-1].to_i
            method_def = "def "+name+"() return @add_num+#{num} end"
            Adder.class_eval(method_def)
            eval(name+"()")
            else
            super.method_missing(name, argu)
        end
    end
end

x = Adder.new(10)

puts x.plus20
puts x.minus2
