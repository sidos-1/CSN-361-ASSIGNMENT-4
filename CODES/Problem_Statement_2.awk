##
# @file Problem_Statement_2.awk
# @brief AWK Script for Problem Statement 2
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
if($1= ="d")
    { c++; }
}

# END process to begin the awk script
# @author Ghetia Siddharth
# @param 
# @date 8/24/2019
#
END{ printf("Total Number of %s packets dropped due to congestion =%d \n",$5, c); }