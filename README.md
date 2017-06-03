# Ahorcado x2

![Ahorcado Logo](https://raw.githubusercontent.com/Webierta/ahorcado2/master/ahorcado/ahorcado.png)

Autor: Jesús Cuerda Villanueva. Versión: 1.0 (2016 - actualmente sin mantenimiento).

Aplicación gratuita y sin publicidad. Colabora con un donativo vía [PayPal](https://goo.gl/SukJub)

## REQUISITOS Y EJECUCIÓN

Aplicación multiplataforma desarrollada con lenguaje de programación Ruby e interfaz gráfica Gtk3.

Requiere tener instalado ruby (versión 2.3.1 o superior) y ruby-gtk3. En Ubuntu y similares tan fácil como:

    sudo apt install ruby
    sudo apt install ruby-gtk3

Para saber cómo instalar ruby en tu sistema: https://www.ruby-lang.org/es/documentation/installation/

Para instalar ruby-gtk3: https://www.gtk.org/download/index.php

Para ejecutar la aplicación descomprime el archivo descargado y escribe en consola (desde el directorio ahorcado) con:

    ruby ahorcado.rb

Probado en Xubuntu 16.10. Las versiones de desarrollo se han probado en ruby v.2.3.0 y v.2.3.1 y viendo ciertas incompatibilidades entre ambas, finalmente se ha optado por la versión más reciente que es la que en ese momento estaba en los repositorios de Ubuntu.

## INSTRUCCIONES DEL JUEGO

Bienvenido al clásico juego de lápiz y papel 'El Ahorcado'. Juego por turnos para dos jugadores.

Esta aplicación revive el clásico juego de lápiz y papel "El Ahorcado". El objetivo del juego es descubrir una palabra oculta.

Turno 1: El jugador 1 propone una palabra secreta y se dibuja una raya por cada letra.

Turno 2: El jugador 2 deberá acertar las letras que componen esa palabra.

Si la palabra oculta contiene esa letra, aparecerá en su lugar correspondiente (tantas veces como se repita).

En caso contrario, por cada error se dibuja una parte de la figura del ahorcado (cabeza, tronco y extremidades) y cada vez se está un poquito más cerca de 'morir' en la horca. La repetición del mismo error no penaliza. 

Se gana el juego si se completa la palabra antes de dibujar completamente el monigote del ahorcado, y se pierde si 'mueres' en la horca (al sexto error).

## LICENCIA

Licencia de Creative Commons CC BY_NC_SA 3.0 ES. Esta obra esta sujeta a la Licencia Reconocimiento-NoComercial-CompartirIgual 3.0 España de Creative Commons. Para ver una copia de esta licencia, visite http://creativecommons.org/licenses/by-nc-sa/3.0/es/
