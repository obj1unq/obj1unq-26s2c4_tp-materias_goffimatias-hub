import materias.*

class Carrera {
    const property materias = #{}

    method materiasDelAño(año) {
        return materias.filter({ materia => materia.año() == año })
    }
}

const programacion = new Carrera(
    materias = #{
        elementosDeProgramacion, 
        matematica1, 
        objetos1, 
        objetos2, 
        objetos3, 
        trabajoFinal, 
        basesDeDatos
    }
)
const medicina = new Carrera(
    materias = #{
        quimica, 
        biologia1, 
        biologia2, 
        anatomíaGeneral
    }
)
const derecho = new Carrera(
    materias = #{
        latin, 
        derechoRomano, 
        historiaDelDerechoArgentino, 
        derechoPenal1, 
        derechoPenal2
    }
)
