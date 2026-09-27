
import carreras.*
import materias.*

class Estudiante {
    const property carreras = #{}
    const property materiasAprobadas = #{}

    // Consultas
    method tieneAprobada(materia) {
        return materiasAprobadas.any({ materiaAprobada => materiaAprobada.materia() == materia })
    }

    // De todas las carreras
    method cantidadMateriasAprobadas() {
        return materiasAprobadas.size()
    }

    method promedio() {
        return materiasAprobadas.map({materiaAprobada => materiaAprobada.nota()}).average()
    }

    method materias() {
        return carreras.map({carrera => carrera.materias()}).flatten()
    }

    method puedeInscribirse(materia) {
        return (
            self.materias().contains(materia) &&
            not self.tieneAprobada(materia) &&
            not materia.estaInscripto(self) &&
            materia.cumpleRequisitos(self)
        )
    }

    // Por carrera
    method cantidadAprobadasEn(carrera) {
        return materiasAprobadas.count({ materiaAprobada => carrera.materias().contains(materiaAprobada.materia()) })
    }

    method creditosAcumulados() {
        return materiasAprobadas.map({materiaAprobada => materiaAprobada.materia().creditos()}).sum()
    }

    // Acciones
    method registrarMateriaAprobada(materia, nota) {
        if (self.tieneAprobada(materia)) {
            self.error("La materia ya fue aprobada")
        }
        materiasAprobadas.add(new MateriaAprobada(materia = materia, nota = nota))
    }
}

// ESTUDIANTES
const roque = new Estudiante(
    carreras = #{programacion, medicina},
    materiasAprobadas = #{
        new MateriaAprobada(materia = matematica1, nota = 8),
        new MateriaAprobada(materia = objetos1, nota = 7)
    }
)