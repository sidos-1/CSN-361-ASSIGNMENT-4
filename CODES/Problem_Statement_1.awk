##
# @file Problem_Statement_1.awk
# @brief AWK Script for Problem Statement 1
# 
#
# @author Ghetia Siddharth
#
# @date 8/24/2019
#

# BEGIN process to begin the awk script
# @author Ghetia Siddharth
# @param 
# @date 8/24/2019
#
BEGIN{ c=0;}
{
if($1=="d")
    { c++;
    printf("Packet type: %s\t Sequence ID : %s\t Packet ID : %s\n",$5,$11,$12);
    }
}

# END process to begin the awk script
# @author Ghetia Siddharth
# @param 
# @date 8/24/2019
#
END{ printf("Packets Dropped =%d\n",c); }