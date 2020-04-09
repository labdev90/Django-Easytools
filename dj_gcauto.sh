# Config temporaires pour gcauto
GCA_PATH="$HOME/labtech/labdev/simplon.co/projets/projetFinal/gestion_concessionnaire_auto"
GCA_PROJECT="${GCA_PATH}/gcauto"
GCA_APP="${GCA_PROJECT}/gcannonces"
GCA_VENV="${GCA_PATH}/venv-gcauto/bin/activate"

alias djgccreatesuperuser="${GCA_PROJECT}/manage.py createsuperuser"
alias djgcrunserver="${GCA_PROJECT}/manage.py runserver"
alias djgcmakemigrate="${GCA_PROJECT}/manage.py makemigrate"
alias djgcmigrate="${GCA_PROJECT}/manage.py migrate"
alias djgcshell="${GCA_PROJECT}/manage.py shell"
alias djgcstartapp="${GCA_PROJECT}/manage.py startapp"
alias gcavenv="source ${GCA_VENV}"

help="djgcauto [-p,--path][-v,--venv][-a,--app][-w,--write][-r,--runserver][-R,--runproject][-U,--superuser][-h,--help]
	-p : Pour se positionner dans le répertoire du projet.
	-v : Activation de l'environnement virtuel.
	-a : Creation d'une application dans le projet. A utiliser avec l'option [-v].
	-s : Ouverture du répertoire dans l'editeur Sublime Text.
	-r : Lancement du serveur de devellopement et ouverture du navigateur web. A utiliser avec l'option [-v].
	-R : Lancement des options suivants : -s -v -r
	-U : Creation d'un super user.
	-h : Afficer l'aide des options disponibles."

function djgcauto ()
{
	if [ -z $@ ]; then
		echo -e "[ErrorCommande] : Aucun paramétre détecté\n"
		echo "${help}"
	else
		for i in $@
		do
			case "${i}" in
				"-p" | "--path") cd ${GCA_PROJECT};;
	
    			"-w" | "--write") subl ${GCA_PROJECT};;

				"-v" | "--venv") gcavenv;;
	
    			"-r" | "--runserver") open http://localhost:8000; djgcrunserver; deactivate;;

				"-a" | "--app") read -p "Nom de l'application : " appli
								gcavenv; djgcstartapp ${appli}; deactivate;;
	
				"-R" | "--runproject")	subl ${GCA_PROJECT}; gcavenv; 
										open http://localhost:8000; djgcrunserver; deactivate;;

				"-U" | "--superuser") gcavenv; djgccreatesuperuser; deactivate;;
	
				"-h" | "--help") echo "${help}"
			esac
		done
	fi
}

# info projet et apps dans dossier caché .info.dj avec nom du projet ou apps, date de création
# registre.dj : Mise à jour a chaque projet et app crée
# Créer un alias a chaque projet créé, gc<nom_du_projet>
# GCA_APP_GCANNONCES
