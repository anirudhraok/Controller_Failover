#!/usr/bin/perl
use warnings;
use strict;

while(1) {
my $t = time();
`ovs-vsctl show > status.txt`;

my $grepstatus = system('grep "is_connected: true" status.txt');

system ("curl http://192.168.164.131:8080/wm/staticflowpusher/list/00:00:de:de:06:b0:53:4a : /json>flow.txt
#list flows 

if ($grepstatus == 256)
{
print ("controller 1 has failed . connecting to controller 2..");
system  ("ovs-vsctl set-controller br1 tcp:192.168.164.133:6633");
   # connecting to controller 2
}
else 
{
   print("controller is stable");
}
sleep(2);
}
#end
