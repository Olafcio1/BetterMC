#!/usr/bin/env bash
function checkex() {
	case $1 in
		"a")
			if [[ -e "$2" ]]
			then
				$3
			else
				$4
			fi
		;;
		"f")
			if [[ -f "$2" ]]
			then
				$3
			else
				$4
			fi
		;;
		"d")
			if [[ -d "$2" ]]
			then
				$3
			else
				$4
			fi
		;;
		"b")
			if [[ -e "$2" ]]
			then
				$4
			else
				$3
			fi
		;;
	esac
}
function repack() {
	case $1 in
		"add")
			mv $2 resourcepacks/$3
		;;
		"del")
			rm resourcepacks/$2
		;;
		"ls")
			ls resourcepacks
		;;
	esac
}
function momang() {
	case $1 in
		"add")
			mv $2 mods/$3
		;;
		"del")
			rm mods/$2
		;;
		"ls")
			ls mods
		;;
	esac
}
function dapack() {
	case $1 in
		"add")
			mv $2 saves/$3/datapacks/$4
		;;
		"del")
			rm saves/$2/datapacks/$3
		;;
		"ls")
			ls saves/$2/datapacks
		;;
	esac
}
function checksame() {
	if [[ "$1" == "$2" ]]
	then
		$3
	else
		$4
	fi
}
function setvar() {
	$1=$2
}
function checkmodlon() {
	checkex -f config/forge-client.toml MLENABLED="t" MLENABLED="f"
}
case $1 in
	"-p")
		echo "Installation Path: `pwd`"
	;;
	"-cp")
		pwd | pbcopy
	;;
	"-m")
		function rtc1() {
			case $2 in
				"add")
					echo -n "Mod filename: "
					read PE1E;
					checkex -a $PE1E "mv $PE1E mods/$PE1E; echo Succesfuly ADDED mod." "echo Cannot: DOES NOT EXISTS"
				;;
				"del")
					echo -n "Mod filename: "
					read PE1E;
					checkex -a $PE1E "rm mods/$PE1E; echo Succesfuly DELETED mod." "echo Cannot: DOES NOT EXISTS"
				;;
				"ls")
					echo "Mods: "
					ls mods
				;;
				*) echo "Usage: -m [ add/del/ls ]" ;;
			esac
		}
		checkmodlon
		checksame $MLENABLED t "rtc1" "echo Bad parameters. Run with parameter -h to show all allowed parameters."
	;;
	"-o")
		echo "Minecraft Options:"
		cat options.txt
	;;
	"-co")
		cat options.txt | pbcopy
	;;
	"-rp")
		case $2 in
			"add")
				echo -n "Resourcepack filename: "
				read PE1E;
				checkex -a $PE1E "mv $PE1E resourcepacks/$PE1E; echo Succesfuly ADDED resourcepack." "echo Cannot: DOES NOT EXISTS"
			;;
			"del")
				echo -n "Resourcepack filename: "
				read PE1E;
				checkex -a resourcepacks/$PE1E "rm resourcepacks/$PE1E; echo Succesfuly DELETED resourcepack." "echo Cannot: DOES NOT EXISTS"
			;;
			"ls")
				echo "Resourcepacks:"
				ls resourcepacks
			;;
			*) echo "Usage: -rp [ add/del/ls ]"
		esac
	;;
	"-dp")
		case $2 in
			"add")
				echo -n "Datapack filename: "
				read PE1E;
				echo -n "World filename: "
				read PE2E;
				checkex -a $PE1E "mv $PE1E saves/$PE2E/datapacks/$PE1E; echo Succesfuly ADDED datapack." "echo Cannot: DOES NOT EXISTS"
			;;
			"del")
				echo -n "Datapack filename: "
				read PE1E;
				echo -n "World filename: "
				read PE2E;
				checkex -a $PE1E "rm saves/$PE2E/datapacks/$PE1E; echo Succesfuly DELTED datapack." "echo Cannot: DOES NOT EXISTS"
			;;
			"ls")
				echo -n "World filename: "
				read PE1E;
				echo "Datapacks:"
				ls saves/$PE1E/datapacks
			;;
			*) echo "Usage: -dp [ add/del/ls ]"
		esac
	;;
	"-w")
		case $2 in
			"del")
				echo -n "World filename: "
				read PE1E;
				checkex -a logs/$PE1E "rm saves/$PE1E; echo Succesfuly DELETED world." "echo Cannot: DOES NOT EXISTS"
			;;
			"ls")
				echo "Worlds:"
				ls saves
			;;
			*) echo "Usage: -w [ del/ls ]"
		esac
	;;
	"-l")
		case $2 in
			"show")
				echo -n "Log filename: "
				read PE1E;
				checkex -a logs/$PE1E "echo Log \"\'$PE1E\':\"; cat logs/$PE1E" "echo Cannot: DOES NOT EXISTS"
			;;
			"del")
				echo -n "Log filename: "
				read PE1E;
				checkex -a logs/$PE1E "echo Log \"\'$PE1E\' deleted.\"" "echo Cannot: DOES NOT EXISTS"
			;;
			"ls")
				echo "Logs:"
				ls logs
			;;
			*) echo "Usage: -l [ show/del/ls ]"
		esac
	;;
	"-cl")
		cat logs/latest.log | pbcopy
	;;
	"-c")
		echo "Crash Reports:"
		ls crash-reports
	;;
	"-h")
		echo "Show Installation Path: -p"
		echo "Copy Installation Path: -cp"
		checkmodlon
		checksame $MLENABLED t "echo Manage Mods: -m" ""
		echo "Show Minecraft Options: -o"
		echo "Copy Minecraft Options: -co"
		echo "Manage Resourcepacks: -rp"
		echo "Manage Datapacks: -dp"
		echo "Manage Worlds: -w"
		echo "Show Logs: -l"
		echo "Copy Latest Log: -cl"
		echo "Show Crash Reports: -c"
	;;
	*) echo "Bad parameters. Run with parameter -h to show all allowed parameters."
esac
