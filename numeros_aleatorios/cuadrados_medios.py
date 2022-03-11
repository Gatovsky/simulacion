import numpy as np
import pandas as pd


def producto_m():
    """
      Generar los 30 primeros números ri a partir de las semillas X0=6893 y X1=6531, observe que cada semilla tiene D=4
    """
    x0 = 6893
    x1 = 6531
    d = 4

    mtrz_x0 = np.array([])
    mtrz_x1 = np.array([])
    mtrz_yn = np.array([])
    mtrz_ri = np.array([])

    for i in range(30):
        x0x1 = x0 * x1
        str_x0x1 = str(x0x1)
        lon2 = str_x0x1.__len__()
        xn = int((lon2 - d) / 2)

        str_substring = str_x0x1[xn: xn + d]
        ri = int(str_substring) / 10000

        mtrz_x0 = np.append(mtrz_x0, x0)
        mtrz_x1 = np.append(mtrz_x1, x1)
        mtrz_yn = np.append(mtrz_yn, x0x1)
        mtrz_ri = np.append(mtrz_ri, ri)

        x0 = x1
        x1 = int(str_substring)

    var_x0 = pd.Series(mtrz_x0, name='x0')
    var_x1 = pd.Series(mtrz_x1, name='x1')
    var_yn = pd.Series(mtrz_yn, name='x0 * x1')
    var_ri = pd.Series(mtrz_ri, name='ri')

    print(pd.concat([var_x0, var_x1, var_yn, var_ri], axis=1))


def producto_m2():
    """
    Generar los primeros 5 números ri a partir de la semilla X0=9803 y con la constante a=6965
    """
    x0 = 9803
    a = 6965

    mtrz_a = np.array([])
    mtrz_x0 = np.array([])
    mtrz_ax0 = np.array([])
    mtrz_ri = np.array([])

    for i in range(5):
        x = a * x0
        str_x = str(x)
        lon_x = str_x.__len__()
        partir = int((lon_x - 4) / 2)

        str_subs = str_x[partir: partir + 4]
        ri = int(str_subs) / 10000

        mtrz_a = np.append(mtrz_a, a)
        mtrz_x0 = np.append(mtrz_x0, x0)
        mtrz_ax0 = np.append(mtrz_ax0, x)
        mtrz_ri = np.append(mtrz_ri, ri)

        x0 = int(str_subs)

    var_a = pd.Series(mtrz_a, name='a')
    var_x0 = pd.Series(mtrz_x0, name='x0')
    var_ax0 = pd.Series(mtrz_ax0, name='a * x0')
    var_ri = pd.Series(mtrz_ri, name='ri')

    print(pd.concat([var_a, var_x0, var_ax0, var_ri], axis=1))


def cuadrados_medios():
    x0 = 2784
    d = 4

    mtrz_x0 = np.array([])
    mtrz_yn = np.array([])
    mtrz_ri = np.array([])

    for i in range(3):
        x02 = pow(x0, 2)
        str_x02 = str(x02)
        lon = str_x02.__len__()
        x = int((lon - d) / 2)

        str_substring = str_x02[x: x + d]
        ri = int(str_substring) / 10000

        mtrz_x0 = np.append(mtrz_x0, x0)
        mtrz_yn = np.append(mtrz_yn, x02)
        mtrz_ri = np.append(mtrz_ri, ri)

        x0 = int(str_substring)

    var_x0 = pd.Series(mtrz_x0, name='x0')
    var_yn = pd.Series(mtrz_yn, name='x0²')
    var_ri = pd.Series(mtrz_ri, name='ri')

    print(pd.concat([var_x0, var_yn, var_ri], axis=1))


def main():
    cuadrados_medios()


if __name__ == '__main__':
    main()
