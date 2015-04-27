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