#!/bin/bash

main(){
	echo -e "Bienvenido \c"; whoami; echo "por favor seleccione una de las siguientes opciones para empezar"
	echo "[1] Listar los comandos"
	echo "[2] Mostrar el estatus de los proyectos o indique el [nombre del proyecto]"
	echo "[3] Iniciar un proyecto o indique el [nombre del proyecto]"
	echo "[4] Detener un proyecto [nombre del proyecto]"
	echo "[5] Instalar Docker"
	echo "[6] Desinstalar docker"
	echo ""
	echo ""
	echo -e "Elija una Opcion: \c";  read opcion

	if [[ $opcion -eq 1 ]]
		then enlistar
	
	elif [[ $opcion -eq  2 ]]
		then mostrarEstatus
		
	elif [[ $opcion -eq  3 ]]
		then install_web_app
		
	elif [[ $opcion -eq  4 ]]
		then stop_webApp
	
	elif [[ $opcion -eq  5 ]]
		then install_docker
	
	elif [[ $opcion -eq  6 ]]
		then uninstall_docker
		
	fi
}

install_docker(){
	#https://cabrajeta.com/como-instalar-docker-en-kali-linux-2020/
	if ! [ -x "$(command -v docker)" ]
		then
		sudo apt-get update
		sudo apt-get install \
     		apt-transport-https \
     		ca-certificates \
     		curl \
     		gnupg-agent \
     		software-properties-common
     		curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
     		echo "deb [arch=amd64] https://download.docker.com/linux/debian buster stable" | sudo tee --append /etc/apt/sources.list > /dev/null
     		sudo apt-get update
		sudo apt-get install docker-ce docker-ce-cli containerd.io
		sudo systemctl enable docker
		sudo docker run hello-world
		echo -e "¿Desea regresar al menu principal? [S/N] \c"; read opcion
		
		if [[ $opcion = "s" || $opcion = "S" ]]
		then
			main
		else
			exit
		fi

	elif sudo service docker status | grep inactive > /dev/null
		then
		echo -e  "docker no se esta ejecutando ¿Desea inicar docker? [S/N] \c"
		read opcion2
		
		if [[ $opcion2 == "S" || $opcion2 == "s" ]]
			then
			sudo systemctl start docker
			echo "Se ha iniciado docker"
			echo "Presiona control + c para continuar"
			sudo service docker status
			main
		else
			echo "Regresando al menu principal"
			main
		fi
	else 
		echo "Docker ya se encuentra instalado y esta operativo por lo que se regresa al menu principal"
		echo "Presiona control + c para continuar"
		sudo service docker status
		echo ""
		echo ""
		main
	fi
}

install_web_app(){
  	aplicacion=$1
	if ! [ -x "$(command -v docker)" ]
	then
		echo "docker no esta instalado, iniciando instalación"
		install_docker
	fi
	
  	if ! [[ $1 == "gruyere" || $1 == "badstore-docker" ]]
  	then
	echo "A continuación se presentan los siguientes contenedores disponibles para su instalación:"
	echo "[1] Gruyere"
	echo "[2] Badstore"
	echo -e "Aplicación: \c"; read opcion
	fi
	if [[ $opcion -eq 1 || $1 == "gruyere" ]]
	then
		echo "This codelab is built around Gruyere /ɡruːˈjɛər/ - a small, cheesy web application that allows its users to publish" 
		echo "snippets of text and store assorted files. Unfortunately, Gruyere has multiple security bugs ranging from cross-site scripting and" 
		echo "cross-site request forgery, to information disclosure, denial of service, and remote code execution. The goal of this codelab is to" 
		echo "guide you through discovering some of these bugs and learning ways to fix them both in Gruyere and in general."
		echo "The codelab is organized by types of vulnerabilities. In each section, you'll find a brief description of a vulnerability and a" 
		echo "task to find an instance of that vulnerability in Gruyere. Your job is to play the role of a malicious hacker and find and exploit" 
		echo "the security bugs. In this codelab, you'll use both black-box hacking and white-box hacking. In black box hacking, you try to find" 
		echo "security bugs by experimenting with the application and manipulating input fields and URL parameters, trying to cause application errors,"
		echo "and looking at the HTTP requests and responses to guess server behavior. You do not have access to the source code," 
		echo "although understanding how to view source and being able to view http headers (as you can in Chrome or LiveHTTPHeaders for Firefox)" 
		echo "is valuable. Using a web proxy like Burp or ZAP may be helpful in creating or modifying requests." 
		echo "In white-box hacking, you have access to the source code and can use automated or manual analysis to identify bugs." 
		echo "You can treat Gruyere as if it's open source: you can read through the source code to try to find bugs. Gruyere is written in Python," 
		echo "so some familiarity with Python can be helpful. However, the security vulnerabilities covered are not Python-specific and you can do most" 
		echo "of the lab without even looking at the code. You can run a local instance of Gruyere to assist in your hacking: for example, you can create"
		echo "an administrator account on your local instance to learn how administrative features work and then apply that knowledge to the" 
		echo "instance you want to hack. Security researchers use both hacking techniques, often in combination, in real life."
		echo ""
		echo ""
		echo -e "¿Desea instalar esta apliación vulnerable? [S/N] \c"; read opcion2
		
		if [[ $opcion2 == "S" || $opcion2 == "s" ]]
			then
			#Primero añadimos el host, hay que poner un condicional en caso de que ya exista, este codigo esta basado en https://gist.github.com/irazasyed/a7b0a079e7727a4315b9
			if [ -n "$(grep gruyere /etc/hosts)" ]
			then
				echo "Gruyere ya se ecnuentra instalado por lo que se regresa al menu principal"
				main
			else  	
            			echo "Añadiendo Gruyere a etc/hosts";
            			sudo -- sh -c -e "echo '127.5.0.1	gruyere' >> /etc/hosts";

            				if [ -n "$(grep gruyere /etc/hosts)" ]
                				then
                    					echo -e "gruyere se añadio correctamente a /etc/hosts";
                    					intalarGruyere
                			else
                    					echo "gruyere no pudo agregarse a /etc/hosts, por favor intente nuevamente";
            				fi
    			fi
		
		else
			echo "Regresando al menu principal"
			main
		fi
		elif [[ $opcion -eq 2 || $1 == "badstore-docker" ]]
			then
			echo "BadStore.net presents a typical three-tier web storefront application. This self-contained application was built from the ground up with" 
			echo "typical security mistakes to serve as a platform for demonstration, security training, evaluation, and testing purposes."
			echo ""
			echo ""
			echo -e "¿Desea instalar esta apliación vulnerable? [S/N] \c"; read opcion3
		
		if [[ $opcion3 == "S" || $opcion3 == "s" ]]
			then
			#Primero añadimos el host, hay que poner un condicional en caso de que ya exista, este codigo esta basado en https://gist.github.com/irazasyed/a7b0a079e7727a4315b9
			if [ -n "$(grep badstore-docker /etc/hosts)" ]
			then
				echo "badstore-docker ya se ecnuentra instalado por lo que se regresa al menu principal"
				main
			else  	
            			echo "Añadiendo badstore-docker a etc/hosts";
            			sudo -- sh -c -e "echo '127.6.0.2	badstore-docker' >> /etc/hosts";

            				if [ -n "$(grep gruyere /etc/hosts)" ]
                				then
                    					echo -e "badstore-docker se añadio correctamente a /etc/hosts";
                    					intalarBadstore-docker
                			else
                    					echo "badstore-docker no pudo agregarse a /etc/hosts, por favor intente nuevamente";
            				fi
    			fi
		
		else
			echo "Regresando al menu principal"
			main
		fi
		fi
			
		
}

function intalarGruyere(){
  nombre=Gruyere		
  proyecto=gruyere     	
  docker=karthequian/gruyere  	
  ip=127.5.0.1
  puerto=8008		
  puerto2=8008	
    if [ "$(sudo docker ps -aq -f name=$proyecto)" ]; 
    then
    	echo "$proyecto se encuentra instalado pero esta apagado por lo que se inciara"
    	sudo docker start $proyecto
    	echo "Puedes consultar aqui: http://gruyere o http://$ip"
  else
  echo "instalando proyecto Gruyere"
  sudo docker run --name $proyecto -d -p $ip:80:$puerto $docker
  sudo docker start $proyecto
  echo "Puedes consultar aqui: http://gruyere o http://$ip"
  fi
}

function intalarBadstore-docker(){
  nombre=Badstore-docker		
  proyecto=badstore-docker     	
  docker=jvhoof/badstore-docker  	
  ip=127.6.0.2
  puerto=80 		
  puerto2=80 	
  
   if [ "$(sudo docker ps -aq -f name=$proyecto)" ]; 
    then
    	echo "$proyecto se encuentra instalado pero esta apagado por lo que se inciara"
    	sudo docker start $proyecto
    	echo "Puedes consultar aqui: http://$proyecto o http://$ip"
  else	
  echo "instalando proyecto Badstore"
  sudo docker run --name $proyecto -d -p $ip:80:$puerto $docker
  sudo docker start $proyecto
  echo "Puedes consultar aqui: http://$proyecto o http://$ip"
  fi
}

uninstall_docker(){
	#https://www.codegrepper.com/code-examples/shell/how+to+remove+docker+in+kali
	sudo apt-get purge -y docker-engine docker docker.io docker-ce docker-ce-cli
	sudo apt-get autoremove -y --purge docker-engine docker docker.io docker-ce  
	
	sudo rm -rf /var/lib/docker /etc/docker
	sudo rm /etc/apparmor.d/docker
	sudo groupdel docker
	sudo rm -rf /var/run/docker.sock
	
	echo "Docker se desinstalo correctamente, regresando al menu principal"
	
	main
}

mostrarEstatus(){
 proyecto=$1
 	if [ -n "${1+set}" ]; then
 		if sudo docker start $1 > /dev/null
 			then
 			sudo docker stats $1
 			echo "$1 se encuentra disponible en http://$1"
 		else
 			echo "$1 no esta disponible prueba a inicarlo desde el menu principal opción 3"
 		fi
 		echo "Regresando al menu principal"
 		main
 	else
 		if sudo docker start gruyere > /dev/null
 		then
 			sudo docker stats gruyere
 			echo "gruyere se encuentra disponible en http://gruyere"
 		else
 			echo "gruyere no esta disponible prueba a inicarlo desde el menu principal opción 3"
 		fi
 		
 		if sudo docker start badstore-docker > /dev/null
 		then
 			sudo docker stats badstore-docker
 			echo "badstore-docker se encuentra disponible en http://badstore-docker  "
 		else
 			echo "badstore-docker no esta disponible prueba a inicarlo desde el menu principal opción 3"
 		fi
 		echo "Regresando al menu principal"
 		main
 	fi
}

enlistar(){
	echo "Esta disponible gruyere y badstore-docker"
	main
}

stop_webApp()
{
  ETC_HOSTS=/etc/hosts
  proyecto=$1
  if [ -n "${1+set}" ]; then
  if [ "$(sudo docker ps -aq -f name=$proyecto)" ]; 
  then
  echo "Apagando $proyecto ......"
  sudo docker stop $proyecto
  sudo sed -i".bak" "/$proyecto/d" $ETC_HOSTS
  sudo docker stats $proyecto
  fi
  else
  echo "Elija una opcion"
  echo "[1] Gruyere"
  echo "[2] Backstore"
  echo -e "Seleccion: \c"; read opcion
  
  if [[ $opcion -eq 1 ]]
  then
  if [ "$(sudo docker ps -aq -f name=$proyecto)" ]; 
  then
  sudo docker stop gruyere
  sudo sed -i".bak" "/gruyere/d" $ETC_HOSTS
  sudo docker stats gruyere
  fi
  elif [[ $opcion -eq 2 ]]
  then
  if [ "$(sudo docker ps -aq -f name=$proyecto)" ]; 
  then
  sudo docker stop badstore-docker
  sudo sed -i".bak" "/badstore-docker/d" $ETC_HOSTS
  sudo docker stats gruyere
  fi
  else
  echo "opcion no valida regresando al menu principal"
  main
  fi
  fi
}

if [[ $1 == "gruyere" ]]
then
	echo "Elija una opción"
	echo "[1] para instalar"
	echo "[2] para detener"
	echo "[3] para mostrar su estatus"
	echo -e "Seleccion: \c" ; read op
	
	if [[ $op -eq 1 ]]
	then
		install_web_app $1
	elif [[ $op -eq 2 ]]
	then 
		stop_webApp $1
	elif [[ $op -eq 3 ]]
	then
		mostrarEstatus $1
	else 
		echo "Opcion no reconocida regresando al menu principal"
		main
	fi
elif [[ $1 == "badstore-docker" ]]
then
	echo "Elija una opción"
	echo "[1] para instalar"
	echo "[2] para detener"
	echo "[3] para mostrar su estatus"
	echo -e "Seleccion: \c" ; read op
	
	if [[ $op -eq 1 ]]
	then
		install_web_app $1
	elif [[ $op -eq 2 ]]
	then 
		stop_webApp $1
	elif [[ $op -eq 3 ]]
	then
		mostrarEstatus $1
	else 
		echo "Opcion no reconocida regresando al menu principal"
		main
	fi
elif [[ $1 == "" ]]
then
	echo "Iniciando menu principal"
	main
else 
	echo "El comando no fue reconocido, estos son los proyectos disponibles:"
	echo ""
	echo ""
	enlistar
	main	
fi
