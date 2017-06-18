#!/bin/bash
	apm="$TDS/atom/resources/app/apm/bin/apm"
	preset=(0 c++ 1 sql 2 bash 3 html/css )

	selected="$(zenity --title="Choix du preset de programation pour atom" --height=400 --width=900 --ok-label=Confirmer --cancel-label=Fermer --hide-header --text="Selectionner la language sur le lequelle vous voulez travailler" --list --checklist --auto-scroll ---column="" --column="Language" "${preset[@]}")"

	sed -n '/disabledPackages:/,/]/p' ~/.atom/config.cson | sed '1d'  | sed '$d'  > disable-packages.txt

	if echo "$selected" | grep -q "c++"; then
		nblignes=$(wc -l preset/atom-packages-c++.bash | cut -f 1 -d ' ')
		for ((i=1; i < $nblignes ;i++))
		{
			ligne=$(sed -n $i\p  preset/atom-packages-c++.bash | cut -d ' ' -f 2)
			if grep -q "$ligne" disable-packages.txt ;
			then
				is_enable=$(sed -n $i\p  preset/atom-packages-c++.bash | cut -f 1 -d ' ')
				if [ $is_enable = "enable" ]
				then
					lignefinal=$(sed -n $i\p  preset/atom-packages-c++.bash)
					lignefinal=$(echo $apm $lignefinal )
					$lignefinal
				else
					echo $ligne "deja desactiver"
				fi
			else
				is_enable=$(sed -n $i\p  preset/atom-packages-c++.bash | cut -f 1 -d ' ')
				if [ $is_enable = "enable" ]
				then
					echo $ligne "deja activé"
				else
					lignefinal=$(sed -n $i\p  preset/atom-packages-c++.bash)
					lignefinal=$(echo $apm $lignefinal )
					$lignefinal
				fi
			fi
		}
	fi

	if echo "$selected" | grep -q "sql"; then
		nblignes=$(wc -l preset/atom-packages-sql.bash | cut -f 1 -d ' ')
		for ((i=1; i < $nblignes ;i++))
		{
			ligne=$(sed -n $i\p  preset/atom-packages-sql.bash | cut -d ' ' -f 2)
			if grep -q "$ligne" disable-packages.txt ;
			then
				is_enable=$(sed -n $i\p  preset/atom-packages-sql.bash | cut -f 1 -d ' ')
				if [ $is_enable = "enable" ]
				then
					lignefinal=$(sed -n $i\p  preset/atom-packages-sql.bash)
					lignefinal=$(echo $apm $lignefinal )
					$lignefinal
				else
					echo $ligne "deja desactiver"
				fi
			else
				is_enable=$(sed -n $i\p  preset/atom-packages-sql.bash | cut -f 1 -d ' ')
				if [ $is_enable = "enable" ]
				then
					echo $ligne "deja activé"
				else
					lignefinal=$(sed -n $i\p  preset/atom-packages-sql.bash)
					lignefinal=$(echo $apm $lignefinal )
					$lignefinal
				fi
			fi
		}
	fi

	if echo "$selected" | grep -q "bash"; then
		nblignes=$(wc -l preset/atom-packages-bash.bash | cut -f 1 -d ' ')
		for ((i=1; i < $nblignes ;i++))
		{
			ligne=$(sed -n $i\p  preset/atom-packages-bash.bash | cut -d ' ' -f 2)
			if grep -q "$ligne" disable-packages.txt ;
			then
				is_enable=$(sed -n $i\p  preset/atom-packages-bash.bash | cut -f 1 -d ' ')
				if [ $is_enable = "enable" ]
				then
					lignefinal=$(sed -n $i\p  preset/atom-packages-bash.bash)
					lignefinal=$(echo $apm $lignefinal )
					$lignefinal
				else
					echo $ligne "deja desactiver"
				fi
			else
				is_enable=$(sed -n $i\p  preset/atom-packages-bash.bash | cut -f 1 -d ' ')
				if [ $is_enable = "enable" ]
				then
					echo $ligne "deja activé"
				else
					lignefinal=$(sed -n $i\p  preset/atom-packages-bash.bash)
					lignefinal=$(echo $apm $lignefinal )
					$lignefinal
				fi
			fi
		}
	fi

	if echo "$selected" | grep -q "html/css"; then
		nblignes=$(wc -l preset/atom-packages-html.bash | cut -f 1 -d ' ')
		for ((i=1; i < $nblignes ;i++))
		{
			ligne=$(sed -n $i\p  preset/atom-packages-html.bash | cut -d ' ' -f 2)
			if grep -q "$ligne" disable-packages.txt ;
			then
				is_enable=$(sed -n $i\p  preset/atom-packages-html.bash | cut -f 1 -d ' ')
				if [ $is_enable = "enable" ]
				then
					lignefinal=$(sed -n $i\p  preset/atom-packages-html.bash)
					lignefinal=$(echo $apm $lignefinal )
					$lignefinal
				else
					echo $ligne "deja desactiver"
				fi
			else
				is_enable=$(sed -n $i\p  preset/atom-packages-html.bash | cut -f 1 -d ' ')
				if [ $is_enable = "enable" ]
				then
					echo $ligne "deja activé"
				else
					lignefinal=$(sed -n $i\p  preset/atom-packages-html.bash)
					lignefinal=$(echo $apm $lignefinal )
					$lignefinal
				fi
			fi
		}
	fi
