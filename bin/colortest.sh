#!/bin/bash


# https://gist.github.com/XVilka/8346728
# http://www.growingwiththeweb.com/2015/05/colours-in-gnome-terminal.html

# Feature:
# Show 16 color text
# Show 16 color text styles
# Show 16 color rainbow
# Show 256 color text
# Show 256 color text style
# Show 256 color rainbow

# Show registered env color vars
# Show common color conventions


show_examples=true
test_tring=TOTO

text_16(){

	echo "Normal colors:"
	for code in {00..07}; do 
		echo -ne "\e[38;05;${code}m$code: "; 

		[[ "${show_examples}" = 'true' ]] \
      && echo -e "echo -e \"\\\e[38;05;${code}m ${test_tring}\"" \
      || echo -e "${test_tring}"

	done
  echo

	echo "Light colors:"
	for code in {08..16}; do 
		echo -ne "\e[38;05;${code}m$code: "; 

		[[ "${show_examples}" = 'true' ]] \
      && echo -e "echo -e \"\\\e[38;05;${code}m ${test_tring}\"" \
      || echo -e "${test_tring}"
	done
  echo
}

text_256(){

  for code in {000..256}; do
    echo -ne "\e[38;05;${code}m$code: ";

    [[ "${show_examples}" = 'true' ]] \
      && echo -e "echo -e \"\\\e[38;05;${code}m ${test_tring}\"" \
      || echo -e "${test_tring}"

  done
  echo

}

full_16() {
	for clbg in {040..047} {100..107} 049 ; do
		#Foreground
		for clfg in {030..037} {090..097} 039 ; do
			#Formatting
			for attr in 0 1 2 4 5 7 ; do
				#Print the result
				echo -en "\e[${attr};${clbg};${clfg}m \\\e[${attr};${clbg};${clfg}m \e[0m"
			done
			echo #Newline
		done
		echo
	done
}

text_16
text_256
full_16


echo -e "\e[0m Reset :)"

exit 0

 
# ONly main colors
T='gYw'   # The test text
echo -e "\n                 40m     41m     42m     43m\
     44m     45m     46m     47m";
for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
           '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
           '  36m' '1;36m' '  37m' '1;37m';
  do FG=${FGs// /}
  echo -en " $FGs \033[$FG  $T  "
  for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
    do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
  done
  echo;
done
echo


# A bit buggy ...
for x in {0..8}; do 
    for i in {30..37}; do 
        for a in {40..47}; do 
            echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "
        done
        echo
    done
done
echo ""


# Print 256 colors
for fgbg in 38 48 ; do #Foreground/Background
  for color in {0..256} ; do #Colors
    #Display the color
    echo -en "\e[${fgbg};5;${color}m ${color}\t\e[0m"
    #Display 10 colors per lines
    if [ $((($color + 1) % 10)) == 0 ] ; then
      echo #New line
    fi
  done
  echo #New line
done

