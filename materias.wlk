import carreras.*

// REQUISITOS
class Correlativa {
    const property materias

    method cumple(estudiante){ 
        return materias.all({ m => estudiante.tieneAprobada(m)}) 
    }
  
}

class PorAño {
    const property carrera
    const property año

    method cumple(estudiante) {
        return carrera.materiasDelAño(año - 1).all({ m => estudiante.tieneAprobada(m) })
    }

}

object sinRequisitos {
    method cumple(estudiante) {
        return true
    }
}

class Credito {
    const property creditos

    method cumple(estudiante) { 
        return estudiante.creditosAcumulados() >= creditos
    }

}

// ESTRATEGIAS
object porOrdenDeLlegada {
    method siguiente(listaDeEspera) {
        return listaDeEspera.first()
    }
}

object elitista {
    method siguiente(listaDeEspera) {
        return listaDeEspera.max({ e => e.promedio() })
    }
}

class PorGradoDeAvance {
    const property carrera

    method siguiente(listaDeEspera) {
        return listaDeEspera.max({ e => e.cantidadAprobadasEn(carrera) })
    }
}

class Materia {
    const nombre
    const cupo
    const creditos
    const año
    const alumnosInscriptos = #{}
    const listaDeEspera = [] 
    var property requisito = sinRequisitos
    var property estrategiaListaDeEspera = porOrdenDeLlegada
  
    
    // Consultas
    method nombre() {
        return nombre 
    }
   
    method cupo() {
        return cupo 
    }

    method creditos() {
        return creditos
    }

    method año() {
        return año
    }

    method cumpleRequisitos(estudiante) {
        return requisito.cumple(estudiante)
    }

    method estaInscripto(estudiante) {
        return alumnosInscriptos.contains(estudiante) || listaDeEspera.contains(estudiante)
    }

    method siguienteEnListaDeEspera() {
        return estrategiaListaDeEspera.siguiente(listaDeEspera)
    }

    method listaDeEspera() {
        return listaDeEspera
    }

    method alumnosInscriptos() {
        return alumnosInscriptos
    }

    method estaConfirmado(estudiante) {
        return self.alumnosInscriptos().contains(estudiante)
    }

    method estaEnListaDeEspera(estudiante) {
        return self.listaDeEspera().contains(estudiante)
    }

    // Acciones
    method validarInscripcion(estudiante) {
        if (not estudiante.puedeInscribirse(self)) {
            self.error("El estudiante no puede inscribirse a " + nombre)
        }
    }

    method inscribir(estudiante) {
        self.validarInscripcion(estudiante)
        if (alumnosInscriptos.size() < cupo) {
            alumnosInscriptos.add(estudiante)
        } else {
            listaDeEspera.add(estudiante)
        }

    }

    method darDeBaja(estudiante) {
        alumnosInscriptos.remove(estudiante)
        self.procesarSiguienteEnEspera()
    }

    method procesarSiguienteEnEspera() {
        if ( not listaDeEspera.isEmpty() ) {
            const siguiente = self.siguienteEnListaDeEspera()
            listaDeEspera.remove(siguiente)
            alumnosInscriptos.add(siguiente)
        }
    }

}

class MateriaAprobada {
    const property materia
    const property nota
}

// MATERIAS
const elementosDeProgramacion = new Materia(
    nombre = "Elementos de Programación",
    cupo = 20,
    creditos = 10,
    año = 1
)
const matematica1 = new Materia(
    nombre = "Matemática 1",
    cupo = 20,
    creditos = 10,
    año = 1
)
const objetos1 = new Materia(
    nombre = "Objetos 1",
    cupo = 20,
    creditos = 10,
    año = 1
)

const objetos2 = new Materia(
    nombre = "Objetos 2", 
    cupo = 3,
    creditos = 10,
    año = 2
)

const objetos3 = new Materia(
    nombre = "Objetos 3",
    cupo = 20,
    creditos = 10,
    año = 3
)

const trabajoFinal = new Materia(
    nombre = "Trabajo Final",
    cupo = 20,
    creditos = 10,
    año = 4
)

const basesDeDatos = new Materia(
    nombre = "Bases de Datos",
    cupo = 20,
    creditos = 10,
    año = 2
)

const quimica = new Materia(
    nombre = "Química",
    cupo = 20,
    creditos = 10,
    año = 1
)

const biologia1 = new Materia(
    nombre = "Biología 1",
    cupo = 20,
    creditos = 10,
    año = 1
)

const biologia2 = new Materia(
    nombre = "Biología 2",
    cupo = 20,
    creditos = 10,
    año = 2
)

const anatomíaGeneral = new Materia(
    nombre = "Anatomía General",
    cupo = 20,
    creditos = 10,
    año = 2
)

const latin = new Materia(
    nombre = "Latín",
    cupo = 20,
    creditos = 10,
    año = 1
)

const derechoRomano = new Materia(
    nombre = "Derecho Romano",
    cupo = 20,
    creditos = 10,
    año = 1
)

const historiaDelDerechoArgentino = new Materia(
    nombre = "Historia del Derecho Argentino",
    cupo = 20,
    creditos = 10,
    año = 2
)

const derechoPenal1 = new Materia(
    nombre = "Derecho Penal 1",
    cupo = 20,
    creditos = 10,
    año = 2
)

const derechoPenal2 = new Materia(
    nombre = "Derecho Penal 2",
    cupo = 20,
    creditos = 10,
    año = 3
)
   