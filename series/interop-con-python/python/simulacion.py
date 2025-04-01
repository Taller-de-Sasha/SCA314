# simu.py computes a simulation of Rayleigh-Taylor instability though an implicit ADI scheme
# Code adapted from a MATLAB implementation, for more details see: A. Kielbowicz et.al. https://doi.org/10.4236/ojfd.2023.131003
# Copyright (C) 2024  Augusto Kielbowicz

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

from numpy import array, ones, random, zeros, diag, zeros_like, ones_like, shape, squeeze, size, sum, min, max, quantile
from scipy.linalg import solve

# from interop import solve_julia as solve
import matplotlib.pyplot as plt
end = None # para usar en los slice


def iniciar_concentracion(grilla, posicion_interfaz, concentracion_inicial):
    concentracion = zeros(grilla+(3,))
    concentracion[:posicion_interfaz, :, 0] = concentracion_inicial
    concentracion[posicion_interfaz:, :, 1] = concentracion_inicial 

    concentracion_interfaz = random.random(grilla[1])
    concentracion_interfaz = concentracion_interfaz / sum(concentracion_interfaz) # normalizo el ruido
    concentracion[posicion_interfaz, :, 0] = concentracion_interfaz
    concentracion[posicion_interfaz, :, 1] = concentracion_interfaz

    return concentracion

def signo(c):
    return -1 if c < 2 else 1

def calcular_rho(concentracion, R):
    rho = (R[0] + R[1] * concentracion[:,:,0] 
            + R[2] * concentracion[:,:,1]
            + R[3] * concentracion[:,:,2])
    return rho

def calcular_psi(psi, rho, delta):
    dx, dy, _ = delta
    dx2, dy2  = (dx**2, dy**2)
    coef = 0.5*(((dx**2)*(dy**2)/(dx**2+dy**2)))
    
    f = zeros_like(rho)
    
    f[1:-1, 1:-1] = coef * (
        (psi[0:-2, 1:-1] + psi[2:end, 1:-1])/dx2
      + (psi[1:-1, 0:-2] + psi[1:-1, 2:end])/dy2
      - (rho[1:-1, 2:end] - rho[1:-1, 0:-2])/(2*dy) 
    )
    f[0 , :] = 0
    f[-1, :] = 0
    f[: , 0] = 0
    f[: ,-1] = 0
    return f

def calcular_velocidad(psi, delta):
    dx, dy, _ = delta
    Dx = zeros_like(psi)
    Dy = zeros_like(psi) 

    Dx[1:-1,:] = - (psi[2:end,:] - psi[0:-2,:])
    Dx[0,:] = -psi[1,:]
    Dx[-1,:] = psi[-2,:]

    Dy[:, 1:-1] = psi[:, 2:end] - psi[:, 0:-2]
    Dy[:,  0] = psi[:, 1]
    Dy[:, -1] = -psi[:, -2]

    vx = Dy/(2*dy)
    vy = Dx/(2*dx)
    return (vx, vy)

def calcular_concentracion_y(concentracion, alpha, beta, lambda_, k_cinetico):
    nx, ny, nc = shape(concentracion)
    C = zeros_like(concentracion)
    
    n = ny
    for i in range(nc):
        for col in range(1,ny-1):
            c = calcular_fila(i, col, concentracion, alpha, beta, lambda_, k_cinetico, nx)
            # print(f"i:{i}, col:{col}, c:{cuantiles(c)}")
            C[1:-1,col, i] = c
    fijar_condiciones_de_borde(C)
    return C

def calcular_fila(i, col, concentracion, alpha, beta, lambda_, k_cinetico, n):
    alpha_x, alpha_y = alpha
    beta_x, beta_y = beta
    condicion_extremos = zeros((n-2,))

    A = construir_matriz_tridiagonal(alpha_x[i], beta_x[:, col], lambda_)
    valor_c = squeeze(concentracion[1:-1, col-1:col+2, i]) 
    coef_ = construir_coef_(alpha_y[i], beta_y[:, col], lambda_) 
    termino_reactivo = signo(i) * k_cinetico * squeeze(concentracion[1:-1, col, 0] * 
    concentracion[1:-1, col, 1]) 
    condicion_extremos[0]  = (alpha_x[i]+beta_x[1,col])*concentracion[0,col,i]
    condicion_extremos[-1] = (alpha_x[i]-beta_x[-2,col])*concentracion[-1,col,i]
    # print(f"coef:{shape(coef_)}, valor_c:{shape(valor_c)}, cext:{shape(condicion_extremos)}, treac:{shape(termino_reactivo)}")
    b = sum(coef_ * valor_c, axis=1) + condicion_extremos + termino_reactivo
    # print(f"CY A:{shape(A)}, b: {shape(b)}")
    c = solve(A, b) # cambiar a solve_banded
    return c
   
def calcular_concentracion_x(concentracion, alpha, beta, lambda_, k_cinetico):
    nx, ny, nc = shape(concentracion)
    C = zeros_like(concentracion)

    for i in range(nc):
        for fila in range(1, nx-1):
            c = calcular_columna(i, fila, concentracion, alpha, beta, lambda_, k_cinetico, ny)
            # print(f"i:{i}, fila:{fila}, c:{cuantiles(c)}")
            C[fila, 1:-1, i] = c
    fijar_condiciones_de_borde(C)
    return C

def calcular_columna(i, fila, concentracion, alpha, beta, lambda_, k_cinetico, n):
    alpha_x, alpha_y = alpha
    beta_x, beta_y = beta
    condicion_extremos = zeros((n-2,))
    A = construir_matriz_tridiagonal(alpha_y[i], beta_y[fila,:], lambda_)
    valor_c = squeeze(concentracion[fila-1:fila+2, 1:-1, i]).T # (ny-2, 3)
    coef_ = construir_coef_(alpha_x[i], beta_x[fila,:], lambda_) # (ny-2, 3)
    termino_reactivo = signo(i) * k_cinetico * squeeze(concentracion[fila, 1:-1, 0] * 
    concentracion[fila, 1:-1, 1]) 
    condicion_extremos[0] = (alpha_y[i]+beta_y[fila,1])*concentracion[fila,0,i]
    condicion_extremos[-1] =(alpha_y[i]-beta_y[fila,-2])*concentracion[fila,-1,i]
    # print(f"coef:{shape(coef_)}, valor_c:{shape(valor_c)}, cext:{shape(condicion_extremos)}, treac:{shape(termino_reactivo)}")
    b = sum(coef_ * valor_c, axis=1) + condicion_extremos + termino_reactivo
    # print(f"CX A:{shape(A)}, b:{shape(b)}")
    c = solve(A, b) # cambiar a solve_banded
    return c

def fijar_condiciones_de_borde(C):
    C[0,  :] = C[2,  :]
    C[-1, :] = C[-3, :]
    C[:,  0] = C[:,  2]
    C[:, -1] = C[:, -3] 

def construir_coef_(alpha, beta, lambda_):
    n = size(beta)
    coef_ = zeros((n-2, 3)) 
    coef_[:, 0] = alpha + beta[1:-1]
    coef_[:, 1] = lambda_ - 2*alpha
    coef_[:, 2] = alpha - beta[1:-1]
    return coef_

def construir_matriz_tridiagonal(alpha, beta, lambda_):
    l = diag(alpha + beta[2:-1], -1)
    d = diag((lambda_+2*alpha)*ones_like(beta[0:-2]))
    u = diag(alpha - beta[1:-2], 1)
    A = - u + d - l
    return A

def calcular_concentracion(concentracion, v, delta, coef_difusion, k_cinetico):
    dx,dy,dt = delta
    beta = (v[0]/(2*dx), v[1]/(2*dy))
    alpha_x, alpha_y = coef_difusion/(dx**2), coef_difusion/(dy**2)
    alpha = (alpha_x, alpha_y)
    lambda_ = 2/dt
    # Paso de método semi-impicito, primero resolver en x, luego en y
    c_intermedio = calcular_concentracion_x(concentracion, alpha, beta, lambda_, k_cinetico)
    # print(f"c_intermedio: {cuantiles(c_intermedio)}")
    # c_intermedio = concentracion
    c = calcular_concentracion_y(c_intermedio, alpha, beta, lambda_, k_cinetico)
    # c = c_intermedio
    # print(f"c: {cuantiles(c)}")
    return c

def avanzar(concentracion, psi, delta, R, coef_difusion, k_cinetico, ax=None):
    rho = calcular_rho(concentracion, R)
    psi_ = calcular_psi(psi, rho, delta)
    v = calcular_velocidad(psi_, delta)

    concentracion_ = calcular_concentracion(concentracion, v, delta, coef_difusion, k_cinetico)

    if ax is not None:
        ax[2,0].imshow(rho)
        ax[2,1].imshow(psi_)
        ax[1,0].imshow(v[0])
        ax[1,1].imshow(v[1])
        plot(ax, concentracion_)

    return (concentracion_, psi_)

def plot(ax, concentracion):
    for i in range(size(concentracion,2)):
        ax[0, i].imshow(concentracion[:,:,i])

def plot_densidad(ax, concentracion, R):
    d = concentracion[:,:,0] + (R[1]/R[0]) * concentracion[:,:,1] + (R[2]/R[0]) * concentracion[:,:,2]
    # print(d)
    ax.imshow(d, vmin=min(d), vmax=max(d))
    # plt.colorbar()

def cuantiles(a): 
    return quantile(a, [0.0,0.01,0.25,0.5,0.75,0.99,1.0])


if __name__ == "__main__":
    grilla_x = 64
    grilla_y = 2 * grilla_x

    dx, dy, dt = 1/2, 1/2, 0.1
    delta = array([dx, dy, dt]) 

    posicion_interfaz = grilla_x // 2

    grilla = (grilla_x, grilla_y)

    concentracion_inicial = 1.0

    coef_difusion = array([0.1, 0.1, 0.1])
    k_cinetico = 0.0

    r0 = 1
    R = array([r0, 5, 1, 1]) 

    concentracion = iniciar_concentracion(grilla, posicion_interfaz, concentracion_inicial)
    psi = ones(grilla)


    pasos = 10
    for t in range(pasos):
        concentracion, psi = avanzar(concentracion, psi, delta, R, coef_difusion, k_cinetico)
    

    # fig, ax = plt.subplots()
    # plot_densidad(ax, concentracion, R)    

    # plt.show()
    # plt.savefig("densidad.png")
    # 10