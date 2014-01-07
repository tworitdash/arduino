#the code sends 'b' over serial port everytime it gets a unread message 
#from gmail
require "serialport"
require "gmail"
#connect to the email id 
gmail = Gmail.new("username","password")

prev_unread = gmail.inbox.count(:unread)

port_file = "COM32" #for windows(linux '/dev/ttyUSB*')
baud_rate = 1200

data_bits = 8
stop_bits = 1
parity = SerialPort::NONE

#create the serialport object
port = SerialPort.new(port_file, baud_rate, data_bits, stop_bits, parity)

wait_time = 4
#for ever
loop do 
	unread = gmail.inbox.count(:unread)
	puts "done counting"
	if unread > prev_unread
		port.write "b"
		puts "yipeeee i got an email, Hurrayyyyyyyyy!!!!!!!!!!!"
	end
	prev_unread = unread
	#for next operation
	#sleep for a while (sending request again to the gmail server)
	sleep wait_time
end