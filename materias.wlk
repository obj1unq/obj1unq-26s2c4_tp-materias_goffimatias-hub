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
    var property alumnosInscriptos = #{}
    var property listaDeEspera = [] 
    const requisito = sinRequisitos
    const estrategiaListaDeEspera = porOrdenDeLlegada
  
    
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
}

class MateriaAprobada {
    const property materia
    const property nota
}

// MATERIAS
const elementosDeProgramacion = new Materia(
    nombre = "Elementos de Programación",
    requisito = sinRequisitos,
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
    requisito = new Correlativa(materias = #{objetos1, matematica1}),
    cupo = 20,
    creditos = 10,
    año = 2
)

const objetos3 = new Materia(
    nombre = "Objetos 3",
    requisito = new PorAño(carrera = programacion, año = 3),
    cupo = 20,
    creditos = 10,
    año = 3
)

const trabajoFinal = new Materia(
    nombre = "Trabajo Final",
    requisito = new Credito(creditos = 250),
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
    requisito = new Correlativa(materias = #{biologia1}),
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
   