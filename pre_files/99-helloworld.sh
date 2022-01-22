clear
echo "
      __  ____                __       
     / / / / /_  __  ______  / /___  __
    / / / / __ \/ / / / __ \/ __/ / / /
   / /_/ / /_/ / /_/ / / / / /_/ /_/ / 
   \____/_.___/\__,_/_/ /_/\__/\__,_/ 
 
		Thanks for using micro-Ubuntu-NAS
		Designed by Teasiu & Hyy2001

   Memory available : $(free -m | grep Mem | awk '{a=$7*100/$2;b=$7} {printf("%.1f%s %.1fM\n",a,"%",b)}')
   Swap available   : $(free -m | grep Swap | awk '{a=$4*100/$2;b=$4} {printf("%.1f%s %.1fM\n",a,"%",b)}')
"

alias reload='. /etc/profile'
alias ramfree='sync && echo 3 > /proc/sys/vm/drop_caches'
alias cls='clear'
