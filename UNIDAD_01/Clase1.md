# Introducción a DevOps
## Filosofía
_Es un movimiento que se basa en la __colaboración__ por parte de las personas que integran, principalmente, las dos área fundamentales de TI que es __Desarrollo__ y __Operaciones__, sin obviar que incluye Seguridad informática._  
__DevOps lo que intenta promover es una cultura de colaboración para acelerar los tiempos de entrega de software en mano de los clientes/usuarios incrementando su calidad.__
~~~text
Dev ───────────────┐
                   │
                DevOps
                   │
Ops ───────────────┘
~~~

## COMPONENTES PRINCIPALES
### Comunicación abierta
La cultura de la organización se debe basar en el debate y en la discusión a través de canales claros de comunicación. Algunos casos que generan una comunicación poco clara pueden ser: tickets, cadenas de mails, documentación no conservada, etc.  
En una cultura devops las herramientas no deben reemplazar la comunicación entre dev y ops sino que debe acompañarla.  
~~~text
        Desarrollo
             │
             │
             ▼
      ┌─────────────┐
      │ Conversación│
      │   conjunta  │
      └─────────────┘
             │
       ┌─────┴─────┐
       ▼           ▼
    DevOps        Ops
       │           │
       └─────┬─────┘
             ▼
       Decisión común
             │
             ▼
       Ticket/documentación
~~~

### Alinear los incentivos y la responsabilidad
Los equipos y las diferentes áreas deben estar propulsadas por una visión orientada a contruir productos de alta calidad, con un alto valor para el cliente y entregarlos de la manera más rápida posible y con el menor riesgo asociado. Establecer este tipo de metas permite definir objetivos específicos de cada área, por ejemplo, los desarrolladores no serán los únicos responsables por generar código que haga el producto bueno, las personas de operaciones no serán castigados por hacer un despliegue a producción que no ocurrió como se esperaba y los testers no serán los únicos responables de agregar calidad. Es decir, __TODOS TIENE EL OBJETIVO Y LA RESPONSABILIDAD DE CONTRUIR EL PRODUCTO LO MEJOR POSIBLE__.

### Respeto
Los miembros de la organización se deben respetar unos a otros, no importa si están en el mismo equipo o no. Se debe considerar a cada persona por el rol que cumple, por el valor que aporta, por su desempeño y por sus actitutes.

### Confianza
Este es un componente fundamentar para que cualquier tipo de relaciones que quieran alcanzar objetivos comunes. La idea de esto es salir de la cultura de definir culpables e ir hacia el aprendizaje, medienate sesiones de análisis, identificando causas raíces y accioines concretas para anclar el aprendizaje identificado en la organización.  

## Metodología LEAN

Principios lean:
* Determinar valor (value): Focalizar y orientar la organización para que todo lo que se contruye sea para satisfacer las necesaidades del cliente.
* Itendificar el flujo del valor (Value stream): Determinar y acordar la secuencia de pasos necesarios desde el principio hasta el final, el cual es la entrega del producto al cliente.
* Generar el flujo (Create flow): Hacer explícito el paso anterior y sentar la base para el principio __pull__.
* Tirar (Pull): Este principio propone que el sistema de producción comienza cuando hay demanda real de parte del cliente sin saturar stocks y capacidades internas de la organización. O sea, este enfoque busca que el flujo de trabajo se adapte a la capacidad real del siguiente paso. Por ejemplo, si un equipo de desarrollo termina 50 funcionalidades pero Operaciones solamente puede desplegar 5 por semana, un enfoque push puede generar un enorme backlog de cosas esperando.
* Perfección (Perfection): Se mejora continuamente. Lo que se puede mejorar: el proceso, la calidad, la moral de los empleados, etc. Una organización LEAN es un sistema que busca la perfección, como un todo.

DevOps se basa en los principios mencionados, los cuales forman un ciclo que aplicado con compromiso pueden transformar equipos, líneas de productos y la organización. Estos principios se deben aplicar también a prácticas de ingeniería de desarrollo de software para que puedan ayudar a lograr el sustento adecuado, generando productos de calidad, reducir el tiempo de entrega y demas.
~~~text
                    ┌──────────────────┐
                    │ IDENTIFICAR      │
                    │     VALOR        │
                    └────────┬─────────┘
                             │
                             ▼
                 ┌──────────────────────┐
                 │ IDENTIFICAR EL FLUJO │
                 └──────────┬───────────┘
                            │
                            ▼
                 ┌──────────────────────┐
                 │    CREAR EL FLUJO    │
                 └──────────┬───────────┘
                            │
                            ▼
                 ┌──────────────────────┐
                 │    HALLAR EL VALOR   │
                 └──────────┬───────────┘
                            │
                            ▼
                 ┌──────────────────────┐
                 │     PERFECCIÓN       │
                 └──────────┬───────────┘
                            │
                            └───────────────┐
                                            │
                                            ▼
                                  IDENTIFICAR VALOR
                                      (ciclo continuo)
~~~

### MUDA (desperdicio)
Uno de los apstectos más concidos de LEAN es la eliminación de desperdicios, los cuales se categorizan usando el siguiente acronimo: DOWNTIME
* _D_. Defects: Defectos en el producto.
* _O_. Overproduction: Exceso de producción de unidades.
* _W_. Wait: Tiempo de espera entre estación de trabajo.
* _N_. Not utilizing taletn: La no utilización de personas que pueden aprotar en otros aspectos de la organización, por ejemplo comunidades de práctica para esparcir el conocimiento y especializar ciertas técnicas.
* _T_. Transportation: Transporte de mercadería o materia prima de un lado a otro innecesariamente. Ej: Tener mas ambientes de los necesarios para desplegar software.
* _I_. Inventory: Inventario de productos sin agregar valor, por ejemplo, producir y almacenarlo porque no se usa.
* _M_. Motion: Cualquier traslado de maquinaria y/o personas que no agregue valor es considerado desperdicio.
* _E_. Excess processing: Exceo de proceso en alguna estación de trabajo. Ej: Crear multiples versiones de la misma tarea.

### LEAN SOFTWARE DEVELOPMENT
Los principios LEAN pueden adaptarse al desarrollo de software, esto incluye los conceptos de desperdicios, las pruebas y la entrega o implementación del rpdocuto, siempre con foco en la mejora continua de la calidad y en la reducción de riesgo.
Adaptando LEAN al desarrollo de software tenemos los siguientes principios:
* _Eliminar el desperdicio_: Quitar actividades que no agregan valor al producto.
* _Construir con calidad_: Siempre velar por la calidad, mientras más rapido se agregue calidad al software más barato será para la organizaci´n la implementación, obteniendo una mejor reputación con el cliente.
* _Crear conocimiento_: Dejar de querer predecir el futuro y basarse en el aprendizaje que el feedback que se genera a partir de las entregas de software.
* _Diferir las decisiones_: La toma de decisiones es un punto critico, por eso este principio se basa en retrasar lo más posible una decisión importante que no se puedda volver atrás para así tener tiempo de conseguir un mayor aprendizaje y disminuyendo la incertidumbre.
* _Entregar lo más pronto posible_: Las entregas tempranas trae reditos económicos, liberar porciones dfe producto que tengan impacto sobre el cliente, disminuye la ansideda de los interesados en el producto, al desplegar funciones en pequeñas porciones de producto genera menor riesgo asociado a errores de despliegue.
* _Respetar a las personas_: Los roles jerárquicos de la organización deben promover que las personas son fundamentales en la organizaci´n y se los debe respetar y apoyar en su desarrollo profesional y personal para que puedan hacer mejor su trabajo.
* _Optimizar toda la organización_: Al momento de3 pensar en optimización de la áreas se piense el todo de una manera sistmática, es decir, la optimización de un sector va a modificar el funcionamiento de otros en la organización. Basicamnete no producir por producir para saturar al siguiente área.

### LEAN STARTUP
Esta metodología consiste en una manera de abordar la construcción de productos con un alto nivel de incertidumbre respecto a si ese producto o servicio tiene demanda en el mercado. La idea es que con el lanzamiento de porciones de producto se valide la hiótesis sobre la necesidad del cliente mediante el feedback. Permitiendo tener un aprendizaje del cliente con la utilización del producto y permite una rápida adaptación.  
Esta metodología centra la mirada en el cliente y no en el producto y se basa en 3 etapas:
* __Construir__: Se desarrrolla el producto en base a la hipótesis que se quiere validar. La primera versión será MVP (Minimo Producto Viable).
* __Medir__: Se establece una serie de métricas que permitan validar la hipótesis.
* __Aprender__: Basandose en las métricas es posible determinar si la hipótesis es válida.

Este ciclo es iterativo, es decir que para cada hipótesis de versión del producto que queremos lanzar se repite el ciclo de aprendizaje a través de la experimentación con el producto desarrollado.

~~~text
                 ┌─────────────────┐
                 │    CONSTRUIR    │
                 │                 │
                 │ Desarrollar el  │
                 │ producto / MVP  │
                 └────────┬────────┘
                          │
                          ▼
                 ┌─────────────────┐
                 │      MEDIR      │
                 │                 │
                 │ Medir resultados│
                 │ y validar       │
                 │ la hipótesis    │
                 └────────┬────────┘
                          │
                          ▼
                 ┌─────────────────┐
                 │    APRENDER     │
                 │                 │
                 │ Analizar el     │
                 │ feedback y      │
                 │ obtener         │
                 │ aprendizaje     │
                 └────────┬────────┘
                          │
                          │
                          └──────────────► CONSTRUIR
~~~

## Metodología AGILE
DevOps además de basarse en la filosofía Lean se baja en los principios y valores de la agilidad, junto a sus prácticas y técnicas. 

### Ciclos de feedback
Esta metodología se basa en ciclos cortos (menores a dos meses) en los que es posible aprender y adaptar el trabajo realizado a la nueva información que proviene de los usuarios para así mejorar el producto y satisfacer sus necesidades.
### Iteraciones
Los ciclos de feedback, en general, definen las iteraciones de desarrollo o definen las implementaciones.
### Incremento
Aqui se plantea que el producto crezca como si fuese un organismo vivo, el software crece como si fuese una planta, y para lograrlo se basa en las principales prácticas y herramientas de inteniería de software.
### Valores
DevOps toma los siguiente pricipios y valores del agilismo:
* __Personas e interacciones sobre procesos y herramientas.__
* __Software funcionando sobre documentación exhaustiva.__
* __Colaboración con el cliente sobre negociación contractual.__
* __Adaptación al cambio sobre el seguimiento de un plan.__

## Cultura de la organización
En una organización donde se promueven los componentes DevOps las personas tienden a colaborar para que todos puedan crear productos de calidad para toda la organización y no para cumplir con la única responsabilidad del área funcional.

### Antipatrones de equipos y organizacionales
Aqui haremos una breve lista de patrones de división de áreas y/o equipos que son propensos a limitar a una organizcaión a la finalidad que tiene DevOps:
* Desarrollo Y Operaciones separados como silos funcionales: El inconveniente radica en que las áreas no colaboran, una vez que el desarrollo está listo se lo pasa a manos Operaciones y si algo sale mal vuelve la atención a desarrollo. Ambas área se comportan como cliente-proveedor.
* Equipo DevOps aislado: La problematica que surge en esta situación, es que el valor que genera la cédula DevOps no alimenta de conocimiento al resto de la organización, sigue siendo un silo funcional, por lo tanto puede provocar un mayor distanciamiento en las interacciones entre las áreas de Desarrollo y Operaciones.
* Desarrollo no necesita de operaciones: La problematica es que desarrollo subestima las habilidades que tiene operaciones para agregar valor al producto y además no se tiene una mirada sistemática sobre la organización en donde ignorar la imporancia de un área, trae consecuencias directas sobre la calidad de lo que se elabora.
* DevOps como equipo de herramientas: Ocurre cuando las organizaciones optan por adoptar un equipo especializado en herramientas en las cuales facilitan los proceso  de despliegue y desarrollo, medición, orquestación y configuración, pero dejando de lado la colaboración de las áreas.
* Re bautizar el rol SysAdmin: Ocurre cuando incorporan personal especializado en las mejores prácticas de ingeniería en desarrollo de software al área de operaciones pero con el título de "DevOps". Este patrón es similar al de "Desarrollo nonecesita de Operaciones". Sólo se optimiza el área de operaciones sin ningún tipo de interacción el área de desarrollo.

