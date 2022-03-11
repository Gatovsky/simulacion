import numpy as np
import pandas as pd


def mixto(x0, k, g):
    #m = pow(2, g)
    m = 7
    #a = 5 + 8 * k
    a = 2
    c = 3
    tiempo_vida = 0
    fst_num = 0
    xi = x0
    mtrz_timvid = np.array([])
    mtrz_xi = np.array([])
    mtrz_ri = np.array([])

    while tiempo_vida < m:
        xi = (a * xi + c) % m
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
