#!/bin/bash

#
#  Archivo con el código asociado a la gestión de procesos
#


menu_principal_procesos()

{    
	

	 while !([ "$opcion_proc" = 'e' ])

do 
     clear	
    echo -e "\n \n"
    echo "*************** MENU PRINCIPAL DE PROCESOS *******************************"
    echo -e "\n \n"
	 echo -e "\t [m] ---> Gestionar señal aplicada a los procesos"
    echo -e "\t [n] ---> Gestionar Prioridad procesos"
     echo -e "\t [b]------> Gestionar procesos en segundo plano"
    echo -e "\t [e]------> Volver al menu principal"
    echo "***********************************************************************************"  
	 echo -e "\n"
	 echo "seleccionar una opcion"	
read opcion_proc
 echo "seleccionar una opcion $opcion_proc"
     case $opcion_proc in

      m) 
	aplicar_senal_proceso
     ;;

     n) 
	modificar_prioridad_proceso
    ;;

     b) 
	funcion_segundo_plano
    ;;
     
     e) 
       echo "volviendo al menu principal"
       
    esac
done

}

aplicar_senal_proceso()

 {   
    	
    echo "Mostrar la información de los procesos"
    ps -la

    echo "introduce ID del proceso a matar"
    read PID
    echo "Introduce la señal a aplicarse"
    kill -l
    read senal
    if [ $senal -gt 65 ]
then
   echo Número introducido mayor que el permitido
   exit 2
fi
  kill -$senal $PID 
  
}      


modificar_prioridad_proceso()


{
   echo "mostrar la información de los procesos"
   ps -la
   echo "introduce ID del proceso a modificar"
   read PID
   echo "introduce la nueva prioridad"
   read prioridad
   renice $prioridad $PID
   if [ $? -eq 0]
   then 
   echo "has cambiado la prioridad"
   ps -ao stat, pcpu,pid,user,frame,nice
  else 
  echo "no has cambiado la prioridad"
  fi

}


funcion_segundo_plano()

{
 echo "mostrar los procesos en segundo plano"
 jobs
 echo "introduce el proceso que quieras pasar a primer plano"
 read n
 fg %$n
 echo "proceso en primer plano"
 jobs
 read parada
 echo "matar el proceso" 
 kill %$n

}







