# Introducción
Esta unidad presentará una serie de prácticas, técnicas y herramientas que ayudarán a comprender los requisitos mínimos que deben tenerse en cuenta para la incorporación de la práctica de integración continua, la cual sienta las bases para DevOps.

## VERSIONADO Y ESTRATEGIAS DE CÓDIGO
Esta sección describe brevemente los sistemas mas utilizados para el control de versiones de aplicaciones, ya sea para el código fuente, documentación, base de datos y otros materiales que requieran tener un historial de cambios.
### Branch
La operación de crear un branch consiste en realizar una copia, en general, de la línea principal del código de la aplicación permitiendo operar en una rama independientemente, es decir, posibilita el desarrollo en paralelo.  
Algunas causas por las que conviene hacer un branch:
* Físicas: Para separar físicamente los archivos y generar independencia entre módulos, subsistemas y sistemas.
* Funcional: Para separar incrementos de funcionalidad, configuraciones, bugs, releases, etc.
* Ambiente: Separar en un branch el ambiente del sistema operativo.
* Organización: Para organizar equipos por funcionalidad, por ejemplo, generar un branch para abordar un conjunto grande de funcionalidades.

La creación de ramificaciones en muchas ocaciones dificulta la práctica de integración continua, sobre todo cuando los equipos son grandes.
_La desición de generar un branch requiere tener definido claramente un proceso y política de cuando hacer el branch, quién puede operar sobre el mismo y quién lo promueve hacia integración con otra rama._   
#### Estrategias de ramifiación:
* __Temprana:__ Crear branchs por cada funcionalidad, pretendiendo evitar grandes cambios en las ramas principales.
* __Tardía:__ Crear un branch en casos excepcionales, de esta manera se minimiza el dolor de realizar los merge. Se debe constituir el hábito de subir los cambios todos los días a la rama principal.

### Merge
Un merge es la union de la nueva rama creada en el branch con la rama principal o cualquier otra.
Esta union suele traer conflicotos a resolver, que pueden ocurrir cuando hay dos cambios en la misma porción de código de dos branches distintos que se quieren unir. Para resolverlo se debe optar por una de las porciones de código. Eso quiere decir que mientras más perdure en el tiempo una rama en donde se esté trabajando más probabilidad de dificultades se tendrán al realizar un merge.

### Estrategias de versionado de código
__Se estará haciendo Integración Continua si los cambios se publican al menos una vez al dia__   
Generar una gran cantidad de branches aumenta la posibilidad de errores en la integración debido a que es mas probable modificar las mismas porciones de código y/o posibles dependencias. Otro problema que mientras más tiempo se demoren en realizar un merge de un branch menos se estará practicando la integracion continua.
_Los branches en un estado no implmentable están generando desperdicio ya que no posibilitan la entrega de valor al cliente_   

#### Branch por Release
La idea es realizar un branch por cada realease que se mantiene viva mientras dure el desarrollo de la versión.

#### Desarollar obre una línea principal (develop on mainline) 
Es una excelente proactica para concebir un desarrollo incremental y una integración continua. Los desarrolladores tendrán que ir agregando pequeños cambios al código de manera que no afecte el comportamiento de la funcionalidad actual de la aplicación.
No todos los cambios que se suban a la línea principal serán implementados, sino que se puede recurrir a implementaciones de un modo oculto.

#### Branch por Feature
Consiste en crear banches para que los equipos puedan desarrllar en simultáneo distintas funcionalidades e integrando su rama al finalizar su trabajo. Una vez finalizado el desarrollo se realiza un merge a la rama principal.
Este enfoque corre el riesgo que un branch no se integre con la rama principal por un largo periodo de tiempo, provocando que elresto de los programadores no obtengan los últimos cambios. Para tratar de evitarlo se deben seguir las siguientes prácticas:
* Cada cambio que se realiza en la línea principal se debe propagar a las ramas.
* Los branches no deben superar los pocos días de vida.
* En lo posible solo se debería realizar un merge de ua rama a la línea principal cuando un tester aecptó el cambio.
* Es recomendable realizar code review de los cambios a integrarse.

#### Branch por equipo
Este tipo de patrón se usa en equipos grandes con flujos de trabajo en simultáneo de funcionalidad y mantenimiento de la línea principal.
En este enfoque, cuando un merge se realiza en la rama principal este mismo cambio se debe propagar desde dicha rama hacia el resto de los equipos. O sea, el merge se debe realizar cuando la rama del equipo están lo suficientemente estable.
Para que funcione se debe dividir ell equipo de trabajo en una pequeña cantidad de integrantes, donde cada uno de llos van a realizas los check-in congtra la rama del equipo y cada vez que se realice un merge se deberá correr toda la bateria de pruebas.


## UNIT TEST & TEST DRIVEN DEVELOPMENT
Para garantizar calidad en modificaciones de código, se utiliza Unit Test permitiendo obtener feedback rápido y concreto en el caso de que algún cambio impacte negativamente.   
__Las pruebas forman parte del producto, pero no del código productivo.__   
Las pruebas unitarias deben ser rápidas, para que el desarrollador pueda obtener feedback instantáneo y actuar con mayor información ante inconvenientes.

### Principio FIRST
Este principio hace referencia a un conjunto de reglas que mejoran la escritura  de unit test.
* __FAST__: Las pruebas deben ejecutarse rápido sino tienden a no ejecutarse, lo que provoca no hallar posibles problemas.
* __INDEPENDENT:__ Las pruebas no deben depender unas de otras, o sea que la ejecución de una prueba no debe condicionar la ejecución de la próxima.
* __REPEATABLE:__ Las pruebas deben poder ejecutarse en cualquier ambiente (desarrollo,QA,etc)
* __SELF-VALIDATING:__ Las pruebas deben tener un valor a probar que sea binario, ya que la prueba por si misma debe indicar el error. Si la prueba no se valida por sí misma entonces requiere el análisis de una persona, por lo que el resultado será subjetivo.
* __TIMELY:__ Las pruebas deben ser escritas lo más temprana posible, justo antes de la escritura del código que será productivo y deben cubrir la mayor cantidad de escenarios posibles.

### Patrón AAA (Arrange, Act, Assert)
Este patrón facilita la legibilidad de la prueba, así como también su mantenimiento.
~~~text
┌──────────────────────┐     ┌──────────────────────┐     ┌──────────────────────┐
│       ARRANGE        │     │         ACT         │     │        ASSERT        │
├──────────────────────┤     ├──────────────────────┤     ├──────────────────────┤
│ ☐ Configurar objetos │ ──► │ ☐ Invocar el caso    │ ──► │ ☐ Verificar que el   │
│ ☐ Inicializar valores│     │   a probar           │     │   comportamiento sea │
│   para las pruebas   │     │                      │     │   el determinado     │
├──────────────────────┤     ├──────────────────────┤     ├──────────────────────┤
│ Los valores deberían │     │                      │     │ Se valida una única  │
│ ser independientes   │     │                      │     │ aserción de código   │
│ del ambiente         │     │                      │     │ por test             │
└──────────────────────┘     └──────────────────────┘     └──────────────────────┘
~~~
Los principales beneficios de unit testing son los siguientes:
* Provee feedback casi instantáneo.
* Código robusto, debido a que se desarroll teniendo en cuenta las pruebas exitosas, las que no y también casos de pruebas de execpciones.
* Incrementa la confianza en el sistema que se está desarrollando.
* Se utiliza para docuemtnafción de casos de prueba dentro del código.

### TDD - Test Driven Development
TDD se refiere al desarrollo guiado por las pruebas, es una práctica que utiliza Unit test y distintas implementaciones de automatización para realizarla.
TDD tiene como objetivo no solo introducir las pruebas lo más temprano posible sino que también el desarrollo emergente del diseño.

__PRIMERO HAY QUE TENER ESCRITA LA PRUEBA ANTES DE DESARROLLAR__

El segundo paso es escribir el código que necesita la prueba para que su ejecución sea exitosa.

Por último, una vez que se tiene la prueba escrita sólo con el código necesario para que dicha prueba se ejecute correctamente, se comienza con la refactorización.

~~~text
        ┌─────────────────────┐
        │ 1. Escribir una     │
        │       prueba        │
        └──────────┬──────────┘
                   │
                   ▼
        ┌─────────────────────┐
        │ 2. Escribir el      │
        │       código        │
        └──────────┬──────────┘
                   │
                   ▼
        ┌─────────────────────┐
        │ 3. Limpiar el       │
        │       código        │
        └──────────┬──────────┘
                   │
                   └──────────────► Volver al paso 1
~~~

Las principales ventajas de utilizar esta práctica:
* Se introducen las pruebas al inicio del desarollo.
* El diseño de la arquitectura emerge de un código diseñado para ser probado.
* El código es altamente reutilizable.
* Aumenta la calidad del software, ya que el número de defectos disminuye.
* La documentación del proyecto está embebida en el código.
* Las pruebas se agregan al proyecto de una manera incremental-
* Motivación de los desarrolladores.

Esta practica también tiene sus desventajas como ser la curva de aprendizaje, ya que dominarla lleva un largo tiempo. Y existe poca cantidad de desarrolladores en el mercado que la dominan.

## TESTING AGIL
Surge de la necesidad de abordar la actividad de probar el sistema o el producto de una manera temprana para acompañar el ciclo de desarrollo de software iterativo e incremental.
En lugar de tener un enfoque predictivo en el cual se desean controlar los cambios que requiere el negocio, se propone que las pruebas (sea el proceso, la documentación, los datos y la manera de ejecutarlas) evolucionen a lo largo del tiempo de vida el producto.
En un enfoque ágil, el tester debe estar “infectado” de creatividad, se debe dar un ámbito de colaboración y participación al inicio del desarrollo y no sólo al final para asegurar cierta calidad.

### BDD - Behavior Driven Development
BDD se puede considerar como un proceso de desarrollo de software que acerca al negocio y a los desarrolladores a colaborar y validar las pruebas que se considerarán necesarias para que un requisito sea dado como terminado.
Se dice que es la evolución de TDD dado que, en lugar de escribir las pruebas unitarias, se escribirán las pruebas que verifiquen el código desarrollado desde
el punto de vista del negocio y en colaboración con este.
El enfoque complementa no sólo a TDD, sino que también nos acercará a otro tipo de técnica la cual se la conoce con el nombre de ATDD (por sus siglas en inglés, Acceptance Test Driven Development).

El lenguaje Gherkin es el más utilizado para la práctica de BDD ya que es entendible/legible por la mayoría de las personas y también por las computadoras para realizar la automatización.

Para comenzar con BDD sólo es necesario comprender estas cinco instancias de este lenguaje 
* Feature: es el nombre de la funcionalidad de negocio. El nombre debe ser unívoco y explícito.
* Scenario: identifica uno de los criterios de aceptación de funcionalidad. Para un determinado feature, se tendrá al menos un escenario de prueba.
* Given: Aquí se detallan los prerrequisitos del sistema para poder probar
el escenario en cuestión
* When: especifica el conjunto de acciones / eventos que se realizarán en la ejecución de la prueba. Son las interacciones que se realizarán con el sistema.
* Then: especifica el resultado esperado de la prueba.

Ejemplos de herramientas para BDD: Cucumber, SpecFlow,Behave,JDave.

Las principales ventajas que posee BDD las podemos enumerar de la siguiente manera:
* Colaboración entre el negocio y el equipo de desarrollo.
* Mejora el entendimiento de las reglas de negocio en el equipo de desarrollo.
* Expansión de la práctica de TDD (genera un mejor entendimiento en los
desarrolladores).
* Aumenta la mantenibilidad de la aplicación.
* Documentación viva en la aplicación.
* Se descubren problemas de usabilidad de manera temprana
* Reduce la cantidad de bugs
* Automatización de pruebas.

### ATDD - Acceptance Test Driven Development
Es una evolución de BDD en el cual ya no es en sí una técnica sino más bien una metodología en la cual los casos de prueba de aceptación son elaborados por el equipo completo de desarrollo inclusive el negocio/usuario.
Esta práctica posee 4 etapas:
En una reunión de conversación (Discuss), primero se debate, desde el punto de vista del usuario, el comportamiento del sistema necesario para considerarse aceptado por todo el equipo, inclusive el negocio. Esto permitirá establecer las espectativas adecuadas sobre lo que se desea contruir.

En la desagregación (Distill), ya habiendo entendido qué se deberá desarrollar se procede a escribir las pruebas de aceptación de manera de capturar el conjunto de pruebas ejecutables que se deberán ejecutar en nuestro framework de automatización.

Desarrollar (Develop), el código. En esta etapa, el equipo desarrollará las pruebas antes elaboradas en un lenguaje común al framework de automatización y se utilizará el enfoque de TDD/BDD en el cual se suceden estos eventos:
Primero se escribe la prueba
* La prueba falla
* Se escribe el código de implementación hasta que la prueba pase
    * Para pruebas unitarias
    * Y para pruebas de aceptación
* Se refactorea el código buscando perfeccionarla y eliminar casos duplicado**

Finalmente, en la demostración (Demo) el equipo junto con el stakeholder observan que las pruebas cumplan las expectativas de comportamiento del sistema que se establecieron en un principio y además se suelen ejecutar pruebas exploratorias sobre el código implementado para detectar posibles riesgos que no se hayan identificado con antelación (estas son pruebas manuales).


## Arquitectura de contenedores/Microservicios
Los contenedores se basan en imágenes de sistemas operativos, a su vez la ejecución de
estos contenedores virtualiza ciertos procesos de la máquina host y son manejados por su
kernel.  

Generalmente, al querer implantar una aplicación y aprovechar los beneficios que nos proveerá la virtualización en contenedores, la arquitectura más utilizada es la de orientada a microservicio o a servicios.   
Dentro de una arquitectura de contenedores, el objetivo al que se apunta es que cada
contenedor posea un servicio (un contenedor, una responsabilidad), que este a su vez
tendrá una especificación de la API por la cual se comunican los clientes (el código
desarrollado).\
Otra ventaja que ofrece es que el servicio que corra escale y crezca de una manera independiente, ya que cualquier modificación que se realice no debería afectar al resto de la aplicación.\

Por otro lado, la arquitectura de microservicios permite tener la flexibilidad de implementar
soluciones de servicios en distintas tecnologías, dado que cada contenedor podría tener
diferentes sistemas operativos (alojados en hosts distintos) ya que posee la característica
de ser desacoplados.

## Orquestador

El orquestador de implementación es el responsable de coordinar la secuencia de pasos
requeridas para poder hacer el despliegue de una aplicación en un ambiente, de una
manera automatizada. El ambiente podría ser pruebas para desarrolladores, pruebas de
integración, pruebas de aceptación o bien producción. Lo recomendable es que el proceso
y los scripts que se utilicen sean los mismos para todos los ambientes. De esta manera se
mantiene probado reiteradas veces tanto el proceso de implementación como los scripts
necesarios para realizarlo.\
Mientras las actividades que realiza el orquestador estén más automatizadas y haya cada
vez menos pasos manuales para el flujo desde el desarrollo hasta la entrega del software
en los ambientes que correspondan (Pipeline), más rentable será para la empresa.\
