#!/usr/bin/perl
use warnings;

system (" curl -d '{"switch": "00:00:de:de:06:b0:53:4a", "name":"flow1", "cookie":"0", "priority":"32768", "ingress-port":"eth1","active":"true", "actions":"output=2"}' http://192.168.164.131:8080/wm/staticflowentrypusher/json");
#staticflow pusher usin controller1

while(1) {
my $t = time();
`ovs-vsctl show > status.txt`;

my $grepstatus = system('grep "is_connected: true" status.txt');

`curl http://192.168.164.131:8080/wm/staticflowentrypusher/list/00:00:de:de:06:b0:53:4a/json > flow.txt`
#list flows

my @splitvalue = split(',', flow.txt);



my $flowvar1 = grep(/^"cookie"/, @splitvalue);
my $flowvar2 = grep(/^"priority"/, @splitvalue);
my $flowvar3 = grep(/^"ingress-port"/,@splitvalue); 
my $flowvar3 = grep(/^"actions"/,@splitvalue); 
#obtaining flow parameters

if ($grepstatus == 256)
{
print ("controller 1 has failed . connecting to controller 2..");
system  ("ovs-vsctl set-controller br1 tcp:192.168.164.133:6633");
   # connecting to controller 2
  system (" curl -d '{"switch": "00:00:de:de:06:b0:53:4a", "name":"flow1", "$flowvar1", "$flowvar2", "$flowvar3","active":"true", "$flowvar4"}' http://192.168.164.133:8080/wm/staticflowentrypusher/json");
#staticflow pusher using controller2
}
else 
{
   print("controller is stable");
   
}
sleep(2);
}
#end
