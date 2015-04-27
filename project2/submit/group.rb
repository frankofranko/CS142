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