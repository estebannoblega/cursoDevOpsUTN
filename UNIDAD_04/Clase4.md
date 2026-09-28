# UNIDAD 4: Entrega Continua
## Introducción
La entrega continua o Continuous Delivery es un paradigma en el que se sostiene el negocio de una organización.   
La principal ventaja de las prácticas y técnicas vistas hasta aquí son utilizadas para
diseñar un pipeline de desarrollo que permita disminuir el riesgo de las implementaciones,
aumentar el feedback de una manera rápida y no tan costosa a través del desarrollo iterativo
e incremental, con menores defectos y la automatización de pruebas e implementaciones
reduciendo el ciclo de entrega.  
La identificación de riesgos es un aspecto importante para establecer Entrega Continua
y sobre todo para la organización que la adopte. Los principales aspectos que se deben
tener en cuenta, no siendo los únicos, son los siguientes:
* Identificación de los riesgos principales del proyecto/producto
* Estrategias para la mitigación de los riesgos identificados
* Estrategia para el seguimiento de los riesgos durante el curso del proyecto/producto
* Definir una estructura para el reporte de estado de los equipos

La esencia de la Entrega Continua es que la organización pueda tener la capacidad de
entregar pequeños cambios de una manera incremental y continua, de manera de no sólo
entregar software rápidamente, sino que además reduzca los riesgos asociados al
introducir cambios en el sistema. La manera en que lo realizará será con el llamado “One
Click Deploy” (implementar con un sólo click). Esto significa que se automatiza todo el
pipeline de desarrollo incluyendo la salida a producción, pero con la diferencia de que
alguien de la organización tendrá la posibilidad de elegir en qué momento implementar el
software que está listo para salir a producción, es decir que para que se realice el pasaje a
producción se requiere una aprobación e intervención manual.

## Infraestructura versionada
Se dice infraestructura versionada al proceso de tener los ambientes de desarrollo,
pruebas, configuraciones, virtualización de hardware, redes y manejo de datos gestionados
a través de un sistema de control de versiones que permita aplicar cambios a través de un
proceso automatizado.\
Hay ciertos aspectos
que se deben tener en cuenta a la hora de implementar la gestión de la infraestructura
mediante un sistema de control de versiones.
* Definiciones de instalación de sistemas operativos
* Versiones de aprovisionamiento de software
* Configuraciones del software que se aprovisiona
* Configuraciones generales tales como DNS, routers, firewalls, SMTP, etc.
* Cualquier script o programa desarrollado para gestionar la infraestructura
Todos estos aspectos son candidatos para estar en un sistema de control de versiones
y embeberlos dentro de la automatización del pipeline. En el caso del ámbito que le
concierne al pipeline, la infraestructura debe inspeccionar principalmente tres aspectos.\
El primero, es que antes de que una aplicación sea implementada en un ambiente se
debe probar que las configuraciones del ambiente (software, configuraciones generales,
aprovisionamiento, pruebas funcionales y no funcionales etc.) sean las definidas en el
sistema de control de versiones.
Segundo, estas definiciones deben ser aplicadas a los distintos ambientes (desarrollo,
pruebas y producción) de una manera automática, recreando la infraestructura a partir de
dichas definiciones que surgen del versionado y la herramienta de gestión.
Y, por último, el pipeline en el momento de hacer la implementación debe ejecutar ciertas
pruebas para verificar que la infraestructura se implementó de una manera correcta.\
La ventaja que trae la infraestructura versionada es la posibilidad de implementar y rehacer nuestra infraestructura desde cero en cualquier momento y dejarla en un estado
"saludable" desde el inicio a través de un proceso automatizado.\
Al tener una infraestructura versionada y gestionada a través de un pipeline
automatizado, cualquier cambio que se quiera introducir se debe hacer mediante un mismo
proceso formal y automatizado, que desencadenará la aplicación y la infraestructura a un
estado saludablemente conocido.\

## Estrategias
