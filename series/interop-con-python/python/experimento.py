from simulacion import array, ones, iniciar_concentracion,  avanzar

def experimento(tamanio_grilla):
    """
    Crea un experimento con una grilla de tamaño: (tamanio_grilla, 2*tamanio_grilla)
    El output es la tripa de (paso, concentracion_inicial, psi_inicial)
    donde paso(concentracion, psi) -> (concentracion, psi) es una función que avanza la simulación en 1 paso de 
    manera que se puede iterar las veces que se quiera o reiniciar una simulación desde unas condiciones establecidas
    """
    grilla_x = tamanio_grilla
    grilla_y = 2*tamanio_grilla
    dx, dy, dt = 1/2, 1/2, 0.1
    delta = array([dx, dy, dt]) 

    posicion_interfaz = grilla_x // 2

    grilla = (grilla_x, grilla_y)

    concentracion_inicial = 1.0

    coef_difusion = array([0.1, 0.1, 0.1])
    k_cinetico = 0.0

    r0 = 1
    R = array([r0, 5, 1, 1]) 

    concentracion_inicial = iniciar_concentracion(grilla, posicion_interfaz, concentracion_inicial)
    psi_inicial = ones(grilla)

    def paso(concentracion, psi):
        concentracion_, psi_ = avanzar(concentracion, psi, delta, R, coef_difusion, k_cinetico)
        return  concentracion_, psi_ 

    return paso, concentracion_inicial, psi_inicial

def simulacion_(n, tam=64):
    paso, ci, pi = experimento(tam)
    c,psi = ci,pi
    for _ in range(n):
        c,psi = paso(c,psi)
        return c, psi