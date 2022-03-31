import random
import numpy as np


# EVALUACIÓN DE CANDIDATOS EN CADA PUESTO #
def evaluacion(array_c_director, array_c_inventor, array_c_oficial, array_c_admin, array_c_auxiliar, b, candidato):
    Rcandidato = np.array([
        np.dot(array_c_director, b),
        np.dot(array_c_inventor, b),
        np.dot(array_c_oficial, b),
        np.dot(array_c_admin, b),
        np.dot(array_c_auxiliar, b)
    ])

    resultados = list()
    sum = 0

    print("\n\n")
    for i in range(5):
        sum = 0
        for j in range(5):
            sum += Rcandidato[i][j]
        resultados.append(sum)

        # print(Rcandidato[i])

    # print("\n suma: \n", sum)
    # print("\n resultados: \n", resultados)

    print("\n ADECUACIÓN DEL CANDIDATO {}\n".format(candidato))
    print("director sucursal {:0.4f} \n"
          "inventor {:0.4f} \n"
          "oficial {:0.4f} \n"
          "administrativo {:0.4f} \n"
          "auxiliar {:0.4f} \n".format(resultados[0], resultados[1], resultados[2], resultados[3], resultados[4]))

    maxi = max(resultados)
    if maxi >= 8.:
        if resultados.index(maxi) == 0:
            print("aplica para el puesto: director sucursal")
        elif resultados.index(maxi) == 1:
            print("aplica para el puesto: inventor")
        elif resultados.index(maxi) == 2:
            print("aplica para puesto: oficial")
        elif resultados.index(maxi) == 3:
            print("aplica para el puesto: administrativo")
        elif resultados.index(maxi) == 4:
            print("aplica para puesto: auxiliar")
    else:
        print("rechazado")


def seleccion():
    # números difusos de nivel
    nivel = {'optimo': [1,1,1,1], 'muy alto': [.93, .98, .99, 1],
                   'bastante alto': [.72, .78, .92, .97], 'alto': [.58, .63, .80, .86],
                   'medio': [.32, .41, .58, .63], 'bajo': [.17, .22, .36, .42],
                   'bastante bajo': [.04, .1, .18, .23], 'muy bajo': [0, .01, .02, .07],
                   'infimo': [0, 0, 0, 0]}

    # números difusos de relación
    relacion = {'excelente': [1, 1, 1, 1], 'muy buena': [.93, .98, .99, 1],
             'bastante buena': [.72, .78, .92, .97], 'buena': [.58, .63, .80, .86],
             'indiferente': [.32, .41, .58, .63], 'mala': [.17, .22, .36, .42],
             'bastante mala': [.04, .1, .18, .23], 'muy mala': [0, .01, .02, .07],
             'pesima': [0, 0, 0, 0]}

    # números difusos de importancia
    importancia = {'impresindible': [1, 1, 1, 1], 'extremadamente_alta': [.93, .98, .99, 1],
                   'muy_alta': [.72, .78, .92, .97], 'bastante_alta': [.58, .63, .80, .86],
                   'media': [.32, .41, .58, .63], 'bastante_baja': [.17, .22, .36, .42],
                   'muy_baja': [.04, .1, .18, .23], 'extremadamente_baja': [0, .01, .02, .07],
                   'innecesaria': [0, 0, 0, 0]}

    # números difusos de importancia de puesto
    iPuesto = {'impresindible': [1, 1, 1, 1], 'extremadamente_alta': [.93, .98, .99, 1],
               'muy_alta': [.72, .78, .92, .97], 'bastante_alta': [.58, .63, .80, .86],
               'media': [.32, .41, .58, .63], 'bastante_baja': [.17, .22, .36, .42],
               'muy_baja': [.04, .1, .18, .23], 'extremadamente_baja': [0, .01, .02, .07],
               'innecesaria': [0, 0, 0, 0]}

    # Puestos vacantes e importancia
    puestos = {'director sucursal': 'impresindible',
               'inventor': 'bastante alta',
               'oficial': 'media',
               'administrativo': 'baja',
               'auxiliar': 'muy_alta'}

    # relación de importancia de cada puesto con los demás
    rdirector = {'director sucursal': '-', 'inventor': 'bastante_alta', 'oficial': 'alta',
                'administrativo': 'media', 'auxiliar': 'bastante_baja'}
    rinventor = {'director sucursal': 'bastante_alta', 'inventor': '-', 'oficial': 'media',
                'administrativo': 'media', 'auxiliar': 'baja'}
    roficial = {'director sucursal': 'baja', 'inventor': 'muy_alta', 'oficial': '-',
                'administrativo': 'muy_alta', 'auxiliar': 'alta'}
    radmin = {'director sucursal': 'baja', 'inventor': 'media', 'oficial': 'muy_alta',
              'administrativo': '-', 'auxiliar': 'muy_alta'}
    rauxiliar = {'director sucursal': 'bastante baja', 'inventor': 'media', 'oficial': 'bastante_alta',
                'administrativo': 'muy alta', 'auxiliar': '-'}

    # conjunto de relaciones de importancia de todos los puestos
    rPuestos ={
        'director sucursal': rdirector,
        'inventor': rinventor,
        'oficial': roficial,
        'administrativo': radmin,
        'auxiliar': rauxiliar
    }

    # tabla = pd.DataFrame(rPuestos)
    # print(tabla.values)

    # listado de competecias generales
    competencias = ['dirigir', 'autorizar', 'fijar_objetivos', 'vision_estrategica',
                    'reunir_informacion', 'analisis', 'control_de_gestion', 'organ',
                    'capacidad de aprendizaje', 'responsabilidad', 'integridad',
                    'comunicacion', 'trabajo_en_equipo', 'flexibilidad', 'calculo',
                    'iniciativa', 'toma_de_decisiones', 'creatividad', 'especializacion',
                    'interfuncional', 'orientacion_comercial', 'atencion_al_cliente',
                    'impacto_personal', 'comunicacion_oral']

    # COMPETENCIAS E IMPORTANCIA DE CADA PUESTO #

    c_director = {'dirigir': iPuesto['impresindible'], 'autorizar': iPuesto['bastante_alta'], 'integridad': iPuesto['media'],
                  'fijar_objetivos': iPuesto['muy_alta'], 'vision_estrategica': iPuesto['bastante_alta']}

    c_inventor = {'reunir informacion': iPuesto['bastante_baja'], 'analisis': iPuesto['extremadamente_alta'], 'control de gestion': iPuesto['bastante_alta'],
                  'organ': iPuesto['media'], 'calculo': iPuesto['media']}

    c_oficial = {'trabajo en equipo': iPuesto['media'], 'flexibilidad': iPuesto['extremadamente_alta'], 'reunir informacion': iPuesto['muy_alta'],
                 'interfuncional': iPuesto['bastante_baja'],'especializacion': iPuesto['bastante_alta']}

    c_administrativo = {'orientacion comercial': iPuesto['media'], 'impacto personal': iPuesto['bastante_baja'], 'comunicacion oral': iPuesto['muy_alta'],
                        'atencion al cliente': iPuesto['bastante_alta'], 'calculo': iPuesto['bastante_alta']}

    c_auxiliar = {'trabajo en equipo': iPuesto['media'], 'flexibilidad': iPuesto['bastante_baja'], 'orientacion comercial': iPuesto['muy_alta'],
                  'impacto personal': iPuesto['bastante_alta'], 'atencion al cliente': iPuesto['muy_alta']}

    # candidatos a cubrir las vacantes
    candidatos_dic = {'c1': [random.random(), random.random(), random.random(), random.random()],
                      'c2': [random.random(), random.random(), random.random(), random.random()],
                      'c3': [random.random(), random.random(), random.random(), random.random()],
                      'c4': [random.random(), random.random(), random.random(), random.random()],
                      'c5': [random.random(), random.random(), random.random(), random.random()],
                      'c6': [random.random(), random.random(), random.random(), random.random()],
                      'c7': [random.random(), random.random(), random.random(), random.random()],
                      'c8': [random.random(), random.random(), random.random(), random.random()]}

    print(candidatos_dic.values())

    # EVALUACIÓN DE CANDIDATOS EN CADA PUESTO #
    # b = np.array([0.9211293476857622, 0.36672541535199765, 0.8385041148242836, 0.3942959745272332])
    # b = candidatos_dic['c1']

    evaluacion(np.array(list(c_director.values()), dtype='float64'), np.array(list(c_inventor.values()), dtype='float64'),
               np.array(list(c_oficial.values()), dtype='float64'), np.array(list(c_administrativo.values()), dtype='float64'),
               np.array(list(c_auxiliar.values()), dtype='float64'), candidatos_dic['c1'], 1)

    evaluacion(np.array(list(c_director.values()), dtype='float64'), np.array(list(c_inventor.values()), dtype='float64'),
               np.array(list(c_oficial.values()), dtype='float64'), np.array(list(c_administrativo.values()), dtype='float64'),
               np.array(list(c_auxiliar.values()), dtype='float64'), candidatos_dic['c2'], 2)

    evaluacion(np.array(list(c_director.values()), dtype='float64'), np.array(list(c_inventor.values()), dtype='float64'),
               np.array(list(c_oficial.values()), dtype='float64'), np.array(list(c_administrativo.values()), dtype='float64'),
               np.array(list(c_auxiliar.values()), dtype='float64'), candidatos_dic['c3'], 3)

    evaluacion(np.array(list(c_director.values()), dtype='float64'), np.array(list(c_inventor.values()), dtype='float64'),
               np.array(list(c_oficial.values()), dtype='float64'), np.array(list(c_administrativo.values()), dtype='float64'),
               np.array(list(c_auxiliar.values()), dtype='float64'), candidatos_dic['c4'], 4)

    evaluacion(np.array(list(c_director.values()), dtype='float64'), np.array(list(c_inventor.values()), dtype='float64'),
               np.array(list(c_oficial.values()), dtype='float64'), np.array(list(c_administrativo.values()), dtype='float64'),
               np.array(list(c_auxiliar.values()), dtype='float64'), candidatos_dic['c5'], 5)

    evaluacion(np.array(list(c_director.values()), dtype='float64'), np.array(list(c_inventor.values()), dtype='float64'),
               np.array(list(c_oficial.values()), dtype='float64'), np.array(list(c_administrativo.values()), dtype='float64'),
               np.array(list(c_auxiliar.values()), dtype='float64'), candidatos_dic['c6'], 6)

    evaluacion(np.array(list(c_director.values()), dtype='float64'), np.array(list(c_inventor.values()), dtype='float64'),
               np.array(list(c_oficial.values()), dtype='float64'), np.array(list(c_administrativo.values()), dtype='float64'),
               np.array(list(c_auxiliar.values()), dtype='float64'), candidatos_dic['c7'], 7)

    evaluacion(np.array(list(c_director.values()), dtype='float64'), np.array(list(c_inventor.values()), dtype='float64'),
               np.array(list(c_oficial.values()), dtype='float64'), np.array(list(c_administrativo.values()), dtype='float64'),
               np.array(list(c_auxiliar.values()), dtype='float64'), candidatos_dic['c8'], 8)


def main():
    seleccion()


if __name__ == '__main__':
    main()



