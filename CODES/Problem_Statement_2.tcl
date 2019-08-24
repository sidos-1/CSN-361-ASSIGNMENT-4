##
# @file Problem_Statement_2.tcl
# @brief TCL Program for Problem Statement 2
# 
#
# @author Ghetia Siddharth
#
# @date 8/24/2019
#

set ns  [new Simulator]

$ns color 0 red
$ns color 1 green
$ns color 2 orange
$ns color 3 blue
$ns color 4 yellow
$ns color 5 magenta
$ns color 6 black
$ns color 7 brown
$ns color 8 purple

# nam file for tracing the network
set nf [open Problem_Statement_2.nam w]
$ns namtrace-all $nf

# trace file for tracing (for awk file)
set tf [open Problem_Statement_2.tr w]
$ns trace-all $tf

# finish process to end the tcl program
# @author Ghetia Siddharth
# @param 
# @date 8/24/2019
#
proc finish {} {
        global ns nf tf

        # clears trace file contents
        $ns flush-trace

        close $nf
        close $tf

        # & - execute it in baclground
        exec nam Problem_Statement_2.nam &
        exit 0
}


# process to print the details of the ping process
# @author Ghetia Siddharth
# @param from rtt
# @date 8/24/2019
#
Agent/Ping instproc recv {from rtt} {
$self instvar node_
puts "node [$node_ id] received packet from $from with round trip time $rtt msec"
}


#input n
puts "Enter Queue Size ( n0 - n2 link ) : "
set N1 [gets stdin]
puts "Enter Queue Size ( n1 - n2 link ) : "
set N2 [gets stdin]
puts "Enter Queue Size ( n2 - n3 link ) : "
set N3 [gets stdin]
puts "Enter Queue Size ( n3 - n4 link ) : "
set N4 [gets stdin]
puts "Enter Queue Size ( n3 - n5 link ) : "
set N5 [gets stdin]


puts "(correct format : 512kB OR 10Mb , etc)"
puts "Enter Bandwidth ( n0 - n2 link ) : "
set B1 [gets stdin]
puts "Enter Bandwidth ( n1 - n2 link ) : "
set B2 [gets stdin]
puts "Enter Bandwidth ( n2 - n3 link ) : "
set B3 [gets stdin]
puts "Enter Bandwidth ( n3 - n4 link ) : "
set B4 [gets stdin]
puts "Enter Bandwidth ( n3 - n5 link ) : "
set B5 [gets stdin]

#creating Nodes        
for {set i 0} {$i<6} {incr i} {
set n($i) [$ns node]
}

#Creating Links: DropTail = Queuing strategy if queue gets full
$ns duplex-link $n(0) $n(2) $B1 1ms DropTail
$ns queue-limit $n(0) $n(2) $N1
$ns duplex-link $n(1) $n(2) $B2 1ms DropTail
$ns queue-limit $n(1) $n(2) $N2
$ns duplex-link $n(2) $n(3) $B3 1ms DropTail
$ns queue-limit $n(2) $n(3) $N3
$ns duplex-link $n(3) $n(4) $B4 1ms DropTail
$ns queue-limit $n(3) $n(4) $N4
$ns duplex-link $n(3) $n(5) $B5 1ms DropTail
$ns queue-limit $n(3) $n(5) $N5

# Generating Ping Agents
set ping(0) [new Agent/Ping]
$ns attach-agent $n(0) $ping(0)
$ping(0) set packetSize_ 5000
$ping(0) set interval_ 0.0001

set ping(1) [new Agent/Ping]
$ns attach-agent $n(1) $ping(1)

set ping(2) [new Agent/Ping]
$ns attach-agent $n(2) $ping(2)

set ping(3) [new Agent/Ping]
$ns attach-agent $n(3) $ping(3)

set ping(4) [new Agent/Ping]
$ns attach-agent $n(4) $ping(4)

set ping(5) [new Agent/Ping]
$ns attach-agent $n(5) $ping(5)
$ping(5) set packetSize_ 5000
$ping(5) set interval_ 0.0001


#PING PACKET TRANSMISSION CONNECTION
$ns connect $ping(0) $ping(4)
$ns connect $ping(5) $ping(1)

# PING PROCESS

for {set i 0.1} {$i < 4} {set i [expr {$i+0.02}]} {
    $ns at $i "$ping(0) send"
}

for {set i 0.1} {$i < 4} {set i [expr {$i+0.02}]} {
    $ns at $i "$ping(5) send"
}

$ns at 4 "finish"
$ns run
