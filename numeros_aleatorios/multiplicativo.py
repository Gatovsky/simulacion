"""
Generar suficientes números entre 0 y 1
con los parámetros: X0 = 17, k = 2 y g = 5,
hasta encontrar el periodo o ciclo de vida
"""
import numpy as np
import pandas as pd


def completar_serie():
    list_x = [65, 89, 98, 3, 69]
    list_tmp = list()
    m = 100
    rn = 0
    mtrz_ri = np.array([])
    mtrz_rn = np.array([])
    xi = list_x[-1]

    # lista original de números
    for i in range(len(list_x)):
        xi = (list_x[i] + xi) % m
        ri = xi / (m - 1)
        rn += 1
        list_tmp.append(xi)
        mtrz_rn = np.append(mtrz_rn, rn)
        mtrz_ri = np.append(mtrz_ri, ri)

    # completar lista de números aleatorios
    for j in range(len(list_tmp) - 3):
        xi = (list_tmp[j] + xi) % m
        ri = xi / (m - 1)
        rn += 1
        mtrz_rn = np.append(mtrz_rn, rn)
        mtrz_ri = np.append(mtrz_ri, ri)

    var_rn = pd.Series(mtrz_rn, name='rn')
    var_ri = pd.Series(mtrz_ri, name='ri')

    print(pd.concat([var_rn, var_ri], axis=1))


def multiplicativo(x0, k, g):
    m = pow(2, g)
    a = 5 + 8 * k
    # c = 7
    tiempo_vida = 0
    fst_num = 0
    xi = x0
    mtrz_timvid = np.array([])
    mtrz_xi = np.array([])
    mtrz_ri = np.array([])

    while tiempo_vida < m:
        # xi = (a * xi) % m
        xi = (a * xi) % m
        ri = xi / (m - 1)

        tiempo_vida += 1
        mtrz_timvid = np.append(mtrz_timvid, tiempo_vida)
        mtrz_xi = np.append(mtrz_xi, xi)
        mtrz_ri = np.append(mtrz_ri, ri)

        if tiempo_vida == 1:
            fst_num = xi

    var_timvid = pd.Series(mtrz_timvid, name='tiempo vida')
    var_xi = pd.Series(mtrz_xi, name='xi')
    var_ri = pd.Series(mtrz_ri, name='ri')

    print(pd.concat([var_timvid, var_xi, var_ri], axis=1))

