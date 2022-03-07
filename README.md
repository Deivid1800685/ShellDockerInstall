# ShellDockerInstall
El presente script permite a los usuarios de Kali linux instalar o desinstalar docker y trae la facilidad de que puedes agregar dos contenedores por defecto que te ayudaran a perfeccionar tus hablidades de hacker

Consideraciones: 
1. Probe utilizar el script en un kali de WSL y no me dejo instalar docker creo que es un error del firewall pero no lo pude solucionar.
2. Si intentas instalar un contenedor y aun no tienes docker automaticamente te lo va instalar
3. Solo esta diponible la aplicación vulnerable Gruyere y Backstore
4. Cuando detienes un docker si se detiene y si corres el comando sudo docker status + 'docker' aparece que no esta usando memoria pero al correr el script y pedirle que te muestre ese estatus nuevamente se va a iniciar pero no se añadira a etc/hosts tendras que darle instalar para que se vuelva a añadir
5. Puedes utilizar un atajo escribiendo gruyere o backstore-docker para trabajar directamente con esos contenedores, al hacer eso solo podras iniciar, mostrar estatus del contenedor y detener el contenedor
6. Si tu instalación llegase a fallar prueba desinstalar y reinstalar

                                                                                                                                                  David Alejandro Avila Olmeda
