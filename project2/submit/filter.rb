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
