class Hogar {
  var property nivelDeMugre = 0
  var property confort = 0
  
  method esBueno() {
    return nivelDeMugre <= confort / 2
  }

  method recibirAtaque(unaPlaga) {
    nivelDeMugre += unaPlaga.nivelDeDaño()
  }
}

class Huerta {
  var property capacidadProduccion = 0

  method esBueno() {
    return capacidadProduccion > nivelProduccionHuerta.nivel()
  }

  method recibirAtaque(unaPlaga) {
    capacidadProduccion -= unaPlaga.nivelDeDaño() * 0.1
    if (unaPlaga.transmiteEnfermedades()) {
      capacidadProduccion -= 10
    }
  }
}

object nivelProduccionHuerta {
  var property nivel = 100
}

class Mascota {
  var property nivelDeSalud = 0

  method esBueno() {
    return nivelDeSalud > 250
  }

  method recibirAtaque(unaPlaga) {
    if (unaPlaga.transmiteEnfermedades()) {
      nivelDeSalud -= unaPlaga.nivelDeDaño()
    }
  }
}

class Barrio {
  var property elementos = []

  method cantidadDeBuenos() = elementos.count({ elem => elem.esBueno() })
  method cantidadDeNoBuenos() = elementos.count({ elem => not elem.esBueno() })

  method esCopado() {
    return self.cantidadDeBuenos() > self.cantidadDeNoBuenos()
  }
}

// --- PLAGAS ---

class Plaga { // En singular por convención de nombres de clases
  var property poblacion = 0 

  method transmiteEnfermedades() {
    return poblacion >= 10
  }

  method nivelDeDaño()

  method realizarAtaque() {
    poblacion += poblacion * 0.1
  }

  method atacar(unElemento) {
    unElemento.recibirAtaque(self) // Primero recibe el daño
    self.realizarAtaque()          // Luego la plaga sufre sus efectos
  }
}

class Cucarachas inherits Plaga {
  var property pesoPromedio = 0

  override method nivelDeDaño() {
    return poblacion / 2
  }

  override method transmiteEnfermedades() {
    return super() and pesoPromedio >= 10
  }

  override method realizarAtaque() {
    super()
    pesoPromedio += 2
  }
}

class Pulgas inherits Plaga {
  override method nivelDeDaño() {
    return poblacion * 2
  }
}

class Garrapatas inherits Pulgas {
  override method realizarAtaque() {
    poblacion += poblacion * 0.2
  }
}

class Mosquitos inherits Plaga {
  override method nivelDeDaño() {
    return poblacion
  }

  override method transmiteEnfermedades() {
    return super() and poblacion % 3 == 0
  }
}