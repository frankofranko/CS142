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
