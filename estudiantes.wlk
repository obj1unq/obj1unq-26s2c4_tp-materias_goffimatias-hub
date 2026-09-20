
import carreras.*
import materias.*

class Estudiante {
    const property carreras = #{}
    const property materiasAprobadas = #{}

    method tieneAprobada(materia) {
        return materiasAprobadas.any({ materiaAprobada => materiaAprobada.materia() == materia })
    }

    method cantidadMateriasAprobadas() {
        return materiasAprobadas.size()
    }

    method promedio() {
        return materiasAprobadas.map({materiaAprobada => materiaAprobada.nota()}).average()
    }

    method registrarMateriaAprobada(materia, nota) {
        if (self.tieneAprobada(materia)) {
            self.error("La materia ya fue aprobada")
        }
        materiasAprobadas.add(new MateriaAprobada(materia = materia, nota = nota))
    }
}

const roque = new Estudiante(
    carreras = #{programacion, medicina},
    materiasAprobadas = #{
        new MateriaAprobada(materia = matematica1, nota = 8),
        new MateriaAprobada(materia = objetos1, nota = 7)
    }
)