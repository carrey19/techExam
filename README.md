# Tech Examn - iOS Development Test

Simple app that shows a menu to set a name and image to upload in firebase storage and a view with charts from an public API.

### Requirements 📋

```
- Xcode 13+
- Swift 5
- MacOS BigSur+
- Cocoapods 1.11.2
```

### Install and Run 🔧

_Just execute the command "pod install" inside the root project downloaded and execute "TechExam.xcworkspace" that was generated with the command._

_The project has a simple realtime databse to change the background color in real time, to see this feature, yoou can add the next line in a View Controller: "ref.child("backgroundColor").setValue({HexStringColor})". The databse is available for writing to test this feature._

### Architecture 🧑‍💻

_It was built with MVP architecture but adding a coordinator to manage the navigation. The decision to use it above other architectures was because the app complexity not requires more and MVVM is better for reactive programing._

## Built with 🛠️

* [Cocoapods](https://cocoapods.org/) - 1.11.2
* [Xcode](https://developer.apple.com/xcode/) - 13
* [Swift](https://www.swift.org/documentation/) - 5


## Developer ✒️

* **Juan Carlos Carrera Reyes** - *Marvel Characters* - [carreracarlosglobant](https://github.com/carreracarlosglobant)

## Answers ✒️
* 6 - Es un proceso que administra un conjunto de vistas y crea la interfaz de usuario de la aplicación. Se coordina con objetos de modelo y otros objetos de controlador. Básicamente, juega un papel combinado tanto para los objetos de vista como para los objetos de controlador.
* 7 - En el ciclo de vida de una aplicación de iOS, lo primero que se llama es: willFinishLaunchingWithOptions. Este método está diseñado para la configuración inicial de la aplicación. Los guiones gráficos ya se han cargado en este punto, pero aún no se ha producido la restauración del estado.
En el Lanzamiento se llaman los siguientes métodos: 
didFinishLaunchingWithOptions. Este método de devolución de llamada se llama cuando la aplicación ha terminado de iniciarse y restaurado el estado y puede realizar la inicialización final, como la creación de una interfaz de usuario.
applicationWillEnterForeground:  si su aplicación se vuelve a activar después de recibir una llamada telefónica u otra interrupción del sistema.
applicationDidBecomeActive: se llama después de applicationWillEnterForeground para finalizar la transición al primer plano.
En la finalización los siguientes métodos:
applicationWillResignActive: se llama cuando la aplicación está a punto de quedar inactiva.
applicationDidEnterBackground: se llama cuando su aplicación entra en un estado de fondo después de estar inactiva. Tiene aproximadamente cinco segundos para ejecutar cualquier tarea que necesite.
applicationWillTerminate: se llama cuando su aplicación está a punto de ser borrada de la memoria.
* 8 - Strong se usa por default en las propiedades, weak se utiliza cuando se necesita que la propiedad inicie con el contador de referencia en 0 ya que puede hacer referencia a otro objeto (strong) y generar un retain cycle además de que su valor es opcional, es decir, puede o no tenerlo. Y el unowned se usa al igual que el weak para iniciar con el contador de referencia en 0 pero en este caso el valor siempre tiene que existir, como en el caso de un Objeto tarjeta hace referencia a un objeto usuario, ya que una tarjeta no puede existir sin un usuario, por ejemplo.
* 9 El ARC o Contador Automático de Referencias es el mecanismo que implementa swift para hacer manejo de la memoria (instancias de los objetos).

## Licence 📄

This project is under MIT License - [LICENSE.md](LICENSE) for more detail

## Thanks for reading me 🎁
