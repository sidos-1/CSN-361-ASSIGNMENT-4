##
# @file Problem_Statement_1.tcl
# @brief TCL Program for Problem Statement 1
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
set nf [open Problem_Statement_1.nam w]
$ns namtrace-all $nf

# trace file for tracing
set tf [open Problem_Statement_1.tr w]
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
        exec nam Problem_Statement_1.nam &
        exit 0
        }

#input n
puts "Enter Queue Size ( n0 - n1 link ) : "
set N1 [gets stdin]
puts "Enter Queue Size ( n1 - n2 link ) : "
set N2 [gets stdin]

puts "(correct format : 512kB OR 10Mb, etc)"
puts "Enter Bandwidth ( n0 - n1 link ) : "
set B1 [gets stdin]
puts "Enter Bandwidth ( n1 - n2 link ) : "
set B2 [gets stdin]

#creating Nodes        
for {set i 0} {$i<expr[3]} {incr i} {
set n($i) [$ns node]
}

#Creating Links: DropTail = Queuing strategy if queue gets full
$ns duplex-link $n(0) $n(1) $B1 10ms DropTail
$ns queue-limit $n(0) $n(1) $N1
$ns duplex-link $n(1) $n(2) $B2 10ms DropTail
$ns queue-limit $n(1) $n(2) $N2

#input k(number of pairs to be connected) pairs
puts "Enter k (number of pairs) (general -> 1 : between n0 (0) and n2 (2) ): "
set k [gets stdin]
puts "Enter k pairs : "
set j 1
for {set i 0} {$i<$k} {incr i} {
        
        puts "Pair : $j \t Node 1 : "
        set n1($i) [gets stdin]
        puts "Pair : $j \t Node 2 : "
        set n2($i) [gets stdin]
        incr j
        
}



#UDP_Config
for {set i 0} {$i < $k} {incr i} {

        set udp($i) [new Agent/UDP]
        $tcp($i) set class_ $i
        $ns attach-agent $n($n1($i)) $udp($i)

# sink node
        set sink($i) [new Agent/Null]
        $ns attach-agent $n($n2($i)) $sink($i)

        $ns connect $udp($i) $sink($i)
}

#CBR (constant bit rate) Config
for {set i 0} {$i < $k} {incr i} {

        set cbr($i) [new Application/Traffic/CBR]
        $cbr($i) set packetSize_ 500
        $cbr($i) set interval_ 0.005
        $cbr($i) attach-agent $udp($i)
}


for {set i 0} {$i < $k} {incr i} {

        $ns at 0.1 "$cbr($i) start"
        
        $ns at 1.5 "$cbr($i) stop"
        
}


$ns at 2 "finish"
$ns run
