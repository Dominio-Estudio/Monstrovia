extends Node

var tutorial = true

onready var is_mobile = ['Android', 'iOS'].has(OS.get_name())

var pantalla_anterior_personalizacion = "res://Inicio.tscn"

var parametros_game_over={
	"a_tiempo": 0,
	"tiempo_restante": 30,
	"monstrificacion": 0,
	"salud": 80
}

var params_avatar = {
	"genero":"mujer",  # hombre,mujer 
	"vestido":"piyama", # piyama, casual, deportivo, formal
	"color": "blanco", # blanco, moreno, negro
	"peinado": "peinado1",
	"color_peinado": "negro" # negro, rubio, castano
}

var assets = {
	"hombre": {
		"frente":{
			"piyama":{
				"blanco": "res://Personaje/hombre piyama.png",
				"moreno": "res://Personaje/hombre piyama 3.png",
				"negro": "res://Personaje/hombre piyama 2.png",
			},
			"casual":{
				"negro": "res://Personaje/hombre ropa casual_2.png",
				"blanco": "res://Personaje/hombre ropa casual.png",
				"moreno": "res://Personaje/hombre ropa casual_1.png",
			},
			"formal":{
				"negro": "res://Personaje/hombre ropa formal_2.png",
				"blanco": "res://Personaje/hombre ropa formal.png",
				"moreno": "res://Personaje/hombre ropa formal_1.png",
			},
			"deportivo":{
				"negro": "res://Personaje/hombre ropa deportiva_2.png",
				"blanco": "res://Personaje/hombre ropa deportiva.png",
				"moreno": "res://Personaje/hombre ropa deportiva_1.png",
			},
			"cabeza":{
				"peinado1":{
					"rubio":{
						"negro": "res://Personaje/cabeza hombre negro rubio_3.png",
						"blanco": "res://Personaje/cabeza hombre blanco rubio_3.png",
						"moreno": "res://Personaje/cabeza hombre moreno rubio_3.png",
						"monstrificado1": "res://Personaje/Monstrificados/hbmm1_3.png",
						"monstrificado2": "res://Personaje/Monstrificados/hbmm2_3.png"
					},
					"castano":{
						"negro": "res://Personaje/cabeza hombre negro castano_3.png",
						"blanco": "res://Personaje/cabeza hombre blanco castano_3.png",
						"moreno": "res://Personaje/cabeza hombre moreno castano_3.png",
						"monstrificado1": "res://Personaje/Monstrificados/hbcm1_3.png",
						"monstrificado2": "res://Personaje/Monstrificados/hbcm2_3.png"
					},
					"negro":{
						"negro": "res://Personaje/cabeza hombre negro _3.png",
						"blanco": "res://Personaje/cabeza hombre blanco_3.png",
						"moreno": "res://Personaje/cabeza hombre moreno_3.png",
						"monstrificado1": "res://Personaje/Monstrificados/hbm1_3.png",
						"monstrificado2": "res://Personaje/Monstrificados/hbm2_3.png"
					}
				},
				"peinado2":{
					"rubio":{
						"negro": "res://Personaje/cabeza hombre negro rubio.png",
						"blanco": "res://Personaje/cabeza hombre blanco rubio.png",
						"moreno": "res://Personaje/cabeza hombre moreno rubio.png",
						"monstrificado1": "res://Personaje/Monstrificados/hbmm1.png",
						"monstrificado2": "res://Personaje/Monstrificados/hbmm2.png"
					},
					"castano":{
						"negro": "res://Personaje/cabeza hombre negro castano.png",
						"blanco": "res://Personaje/cabeza hombre blanco castano.png",
						"moreno": "res://Personaje/cabeza hombre moreno castano.png",
						"monstrificado1": "res://Personaje/Monstrificados/hbcm1.png",
						"monstrificado2": "res://Personaje/Monstrificados/hbcm2.png"
					},
					"negro":{
						"negro": "res://Personaje/cabeza hombre negro .png",
						"blanco": "res://Personaje/cabeza hombre blanco.png",
						"moreno": "res://Personaje/cabeza hombre moreno.png",
						"monstrificado1": "res://Personaje/Monstrificados/hbm1.png",
						"monstrificado2": "res://Personaje/Monstrificados/hbm2.png"
					}
				},
				"peinado3":{
					"rubio":{
						"negro": "res://Personaje/cabeza hombre negro rubio_1.png",
						"blanco": "res://Personaje/cabeza hombre blanco rubio_1.png",
						"moreno": "res://Personaje/cabeza hombre moreno rubio_1.png",
						"monstrificado1": "res://Personaje/Monstrificados/hbmm1_1.png",
						"monstrificado2": "res://Personaje/Monstrificados/hbmm2_1.png"
					},
					"castano":{
						"negro": "res://Personaje/cabeza hombre negro castano_1.png",
						"blanco": "res://Personaje/cabeza hombre blanco castano_1.png",
						"moreno": "res://Personaje/cabeza hombre moreno castano_1.png",
						"monstrificado1": "res://Personaje/Monstrificados/hbcm1_1.png",
						"monstrificado2": "res://Personaje/Monstrificados/hbcm2_1.png"
					},
					"negro":{
						"negro": "res://Personaje/cabeza hombre negro _1.png",
						"blanco": "res://Personaje/cabeza hombre blanco_1.png",
						"moreno": "res://Personaje/cabeza hombre moreno_1.png",
						"monstrificado1": "res://Personaje/Monstrificados/hbm1_1.png",
						"monstrificado2": "res://Personaje/Monstrificados/hbm2_1.png"
					}
				}
			}
		},
		"cicla":{
			"casual":{
				"pierna_atras": "res://Personaje/avatar_montando_bici/pierna 01_1.png",
				"pierna_adelante": "res://Personaje/avatar_montando_bici/pierna 01.png",
				"pantorrilla_atras": "res://Personaje/avatar_montando_bici/pantorilla atras 01.png",
				"pantorrilla_adelante": "res://Personaje/avatar_montando_bici/pantorrilla 01.png",
				"tronco":"res://Personaje/avatar_montando_bici/tronco 01 casual.png",
				"brazo": {
					"blanco":"res://Personaje/avatar_montando_bici/brazo 01.png",
					"moreno":"res://Personaje/avatar_montando_bici/brazo 01.png",
					"negro":"res://Personaje/avatar_montando_bici/brazo 01.png"
				},
				"antebrazo": {
					"blanco": "res://Personaje/avatar_montando_bici/antebrazo 01.png",
					"moreno": "res://Personaje/avatar_montando_bici/antebrazo 01_2.png",
					"negro": "res://Personaje/avatar_montando_bici/antebrazo 01_3.png",
				},
				"zapato": "res://Personaje/avatar_montando_bici/zapato 01.png",
			},
			"formal":{
				"pierna_atras": "res://Personaje/avatar_montando_bici/pierna 02_1.png",
				"pierna_adelante": "res://Personaje/avatar_montando_bici/pierna 02.png",
				"pantorrilla_atras": "res://Personaje/avatar_montando_bici/pantorilla 02_1.png",
				"pantorrilla_adelante": "res://Personaje/avatar_montando_bici/pantorilla 02.png",
				"tronco": "res://Personaje/avatar_montando_bici/tronco 01 formal.png",
				"brazo": {
					"blanco": "res://Personaje/avatar_montando_bici/brazo 01.png",
					"moreno": "res://Personaje/avatar_montando_bici/brazo 01.png",
					"negro": "res://Personaje/avatar_montando_bici/brazo 01.png",
				},
				"antebrazo": {
					"blanco":"res://Personaje/avatar_montando_bici/antebrazo 01.png",
					"moreno":"res://Personaje/avatar_montando_bici/antebrazo 01.png",
					"negro":"res://Personaje/avatar_montando_bici/antebrazo 01.png"
				},
				"zapato": "res://Personaje/avatar_montando_bici/zapato formal.png",
			},
			"deportivo":{
				"pierna_atras": {
					"negro": "res://Personaje/avatar_montando_bici/pierna 06.png",
					"moreno": "res://Personaje/avatar_montando_bici/pierna 06_2.png",
					"blanco": "res://Personaje/avatar_montando_bici/pierna 06_4.png"
				},
				"pierna_adelante": {
					"negro": "res://Personaje/avatar_montando_bici/pierna 06_1.png",
					"moreno": "res://Personaje/avatar_montando_bici/pierna 06_3.png",
					"blanco": "res://Personaje/avatar_montando_bici/pierna 06_5.png"
				},
				"pantorrilla_atras": {
					"negro": "res://Personaje/avatar_montando_bici/pantorilla 06.png",
					"moreno": "res://Personaje/avatar_montando_bici/pantorilla 06_2.png",
					"blanco": "res://Personaje/avatar_montando_bici/pantorilla 06_4.png"
				},
				"pantorrilla_adelante": {
					"negro": "res://Personaje/avatar_montando_bici/pantorilla 06_1.png",
					"moreno": "res://Personaje/avatar_montando_bici/pantorilla 06_3.png",
					"blanco": "res://Personaje/avatar_montando_bici/pantorilla 06_5.png"
				},
				"tronco": "res://Personaje/avatar_montando_bici/tronco 01 deportivo.png",
				"brazo": {
					"negro": "res://Personaje/avatar_montando_bici/brazo 04.png",
					"moreno": "res://Personaje/avatar_montando_bici/brazo 04_1.png",
					"blanco": "res://Personaje/avatar_montando_bici/brazo 04_2.png"
				},
				"antebrazo": {
					"blanco":"res://Personaje/avatar_montando_bici/antebrazo 04_2.png",
					"moreno":"res://Personaje/avatar_montando_bici/antebrazo 04_1.png",
					"negro":"res://Personaje/avatar_montando_bici/antebrazo 04.png"
				},
				"zapato": "res://Personaje/avatar_montando_bici/zapato deportivo.png",
			},
			"cabeza":{
				"mounstruo":"res://Personaje/avatar_montando_bici/cabeza 11 hm_4.png",
				"peinado1":{
					"rubio":{
						"negro": "res://Personaje/avatar_montando_bici/cabeza 09 hn_4.png",
						"blanco": "res://Personaje/avatar_montando_bici/cabeza 01 hb_2.png",
						"moreno": "res://Personaje/avatar_montando_bici/cabeza 06 hmm_4.png",
						"monstrificado1": "res://Personaje/avatar_montando_bici/cabeza 10 hm_4.png",
						"monstrificado2": "res://Personaje/avatar_montando_bici/cabeza 11 hm_2.png"
					},
					"castano":{
						"negro": "res://Personaje/avatar_montando_bici/cabeza 08 hn_3.png",
						"blanco": "res://Personaje/avatar_montando_bici/cabeza 02 hbc_3.png",
						"moreno": "res://Personaje/avatar_montando_bici/cabeza 05 hmc_4.png",
						"monstrificado1": "res://Personaje/avatar_montando_bici/cabeza 10 hc_3.png",
						"monstrificado2": "res://Personaje/avatar_montando_bici/cabeza 11 hc_3.png"
					},
					"negro":{
						"negro": "res://Personaje/avatar_montando_bici/cabeza 07 hn_2.png",
						"blanco": "res://Personaje/avatar_montando_bici/cabeza 01.png",
						"moreno": "res://Personaje/avatar_montando_bici/cabeza 04 hm_5.png",
						"monstrificado1": "res://Personaje/avatar_montando_bici/cabeza 10 h_4.png",
						"monstrificado2": "res://Personaje/avatar_montando_bici/cabeza 11 h_2.png"
					}
				},
				"peinado2":{
					"rubio":{
						"negro": "res://Personaje/avatar_montando_bici/cabeza 09 hn_1.png",
						"blanco": "res://Personaje/avatar_montando_bici/cabeza 03 hbm_1.png",
						"moreno": "res://Personaje/avatar_montando_bici/cabeza 06 hmm_1.png",
						"monstrificado1": "res://Personaje/avatar_montando_bici/cabeza 10 hm_1.png",
						"monstrificado2": "res://Personaje/avatar_montando_bici/cabeza 11 hm.png"
					},
					"castano":{
						"negro": "res://Personaje/avatar_montando_bici/cabeza 08 hn_1.png",
						"blanco": "res://Personaje/avatar_montando_bici/cabeza 02 hbc_1.png",
						"moreno": "res://Personaje/avatar_montando_bici/cabeza 05 hmc_1.png",
						"monstrificado1": "res://Personaje/avatar_montando_bici/cabeza 10 hc_1.png",
						"monstrificado2": "res://Personaje/avatar_montando_bici/cabeza 11 hc_1.png"
					},
					"negro":{
						"negro": "res://Personaje/avatar_montando_bici/cabeza 07 hn_1.png",
						"blanco": "res://Personaje/avatar_montando_bici/cabeza 01 hb_1.png",
						"moreno": "res://Personaje/avatar_montando_bici/cabeza 04 hm_1.png",
						"monstrificado1": "res://Personaje/avatar_montando_bici/cabeza 10 h_1.png",
						"monstrificado2": "res://Personaje/avatar_montando_bici/cabeza 11 h_1.png"
					}
				},
				"peinado3":{
					"rubio":{
						"negro": "res://Personaje/avatar_montando_bici/cabeza 09 hn_2.png",
						"blanco": "res://Personaje/avatar_montando_bici/cabeza 03 hbm_2.png",
						"moreno": "res://Personaje/avatar_montando_bici/cabeza 06 hmm_2.png",
						"monstrificado1": "res://Personaje/avatar_montando_bici/cabeza 10 hm_2.png",
						"monstrificado2": "res://Personaje/avatar_montando_bici/cabeza 11 hm_1.png"
					},
					"castano":{
						"negro": "res://Personaje/avatar_montando_bici/cabeza 08 hn_2.png",
						"blanco": "res://Personaje/avatar_montando_bici/cabeza 02 hbc_2.png",
						"moreno": "res://Personaje/avatar_montando_bici/cabeza 05 hmc_2.png",
						"monstrificado1": "res://Personaje/avatar_montando_bici/cabeza 10 hc_2.png",
						"monstrificado2": "res://Personaje/avatar_montando_bici/cabeza 11 hc_2.png"
					},
					"negro":{
						"negro": "res://Personaje/avatar_montando_bici/cabeza 07 hn_2.png",
						"blanco": "res://Personaje/avatar_montando_bici/cabeza 02 hbc_2.png", #TODO Cambiar
						"moreno": "res://Personaje/avatar_montando_bici/cabeza 04 hm_5.png",
						"monstrificado1": "res://Personaje/avatar_montando_bici/cabeza 10 h_2.png",
						"monstrificado2": "res://Personaje/avatar_montando_bici/cabeza 11 hc_2.png" #TODO Cambiar
					}
				},
			}
		}
	},
	"mujer":{
		"frente":{
			"piyama":{
				"blanco": "res://Personaje/mujer piyama.png",
				"moreno": "res://Personaje/mujer piyama 3.png",
				"negro": "res://Personaje/mujer piyama 2.png",
			},
			"casual":{
				"blanco": "res://Personaje/mujer ropa casual.png",
				"moreno": "res://Personaje/mujer ropa casual_1.png",
				"negro": "res://Personaje/mujer ropa casual_2.png",
			},
			"formal":{
				"blanco": "res://Personaje/mujer ropa formal.png",
				"moreno": "res://Personaje/mujer ropa formal_1.png",
				"negro": "res://Personaje/mujer ropa formal_2.png",
			},
			"deportivo":{
				"blanco": "res://Personaje/mujer ropa deportiva.png",
				"moreno": "res://Personaje/mujer ropa deportiva_1.png",
				"negro": "res://Personaje/mujer ropa deportiva_2.png",
			},
			"cabeza":{
				"peinado1":{
					"rubio":{
						"negro": "res://Personaje/cabeza mujer rubia_4.png",
						"blanco": "res://Personaje/cabeza mujer blanca rubia_4.png",
						"moreno": "res://Personaje/cabeza mujer morena rubia_6.png",
						"monstrificado1": "res://Personaje/Monstrificados/mbmm1_5.png",
						"monstrificado2": "res://Personaje/Monstrificados/mbmm2_4.png"
					},
					"castano":{
						"negro": "res://Personaje/cabeza mujer castana_4.png",
						"blanco": "res://Personaje/cabeza mujer blanca castano_4.png",
						"moreno": "res://Personaje/cabeza mujer morena castana_4.png",
						"monstrificado1": "res://Personaje/Monstrificados/mbcm1_5.png",
						"monstrificado2": "res://Personaje/Monstrificados/mbcm2_5.png.png"
					},
					"negro":{
						"negro": "res://Personaje/cabeza mujer negra_4.png",
						"blanco": "res://Personaje/cabeza mujer blanca_6.png",
						"moreno": "res://Personaje/cabeza mujer morena_4.png",
						"monstrificado1": "res://Personaje/Monstrificados/mbm1_5.png",
						"monstrificado2": "res://Personaje/Monstrificados/mbm2_5.png"
					}
				},
				"peinado2":{
					"rubio":{
						"negro": "res://Personaje/cabeza mujer rubia.png",
						"blanco": "res://Personaje/cabeza mujer blanca rubia.png",
						"moreno": "res://Personaje/cabeza mujer morena rubia.png",
						"monstrificado1": "res://Personaje/Monstrificados/mbmm1.png",
						"monstrificado2": "res://Personaje/Monstrificados/mbmm2.png"
					},
					"castano":{
						"negro": "res://Personaje/cabeza mujer castana.png",
						"blanco": "res://Personaje/cabeza mujer blanca castano.png",
						"moreno": "res://Personaje/cabeza mujer morena castana.png",
						"monstrificado1": "res://Personaje/Monstrificados/mbcm1.png",
						"monstrificado2": "res://Personaje/Monstrificados/mbcm2.png"
					},
					"negro":{
						"negro": "res://Personaje/cabeza mujer negra.png",
						"blanco": "res://Personaje/cabeza mujer blanca.png",
						"moreno": "res://Personaje/cabeza mujer morena.png",
						"monstrificado1": "res://Personaje/Monstrificados/mbm1.png",
						"monstrificado2": "res://Personaje/Monstrificados/mbm2.png"
					}
				},
				"peinado3":{
					"rubio":{
						"negro": "res://Personaje/cabeza mujer rubia_1.png",
						"blanco": "res://Personaje/cabeza mujer blanca rubia_1.png",
						"moreno": "res://Personaje/cabeza mujer morena rubia_1.png",
						"monstrificado1": "res://Personaje/Monstrificados/mbmm1_1.png",
						"monstrificado2": "res://Personaje/Monstrificados/mbmm2_1.png"
					},
					"castano":{
						"negro": "res://Personaje/cabeza mujer castana_1.png",
						"blanco": "res://Personaje/cabeza mujer blanca castano_1.png",
						"moreno": "res://Personaje/cabeza mujer morena castana_1.png",
						"monstrificado1": "res://Personaje/Monstrificados/mbcm1_1.png",
						"monstrificado2": "res://Personaje/Monstrificados/mbcm2_1.png"
					},
					"negro":{
						"negro": "res://Personaje/cabeza mujer negra_1.png",
						"blanco": "res://Personaje/cabeza mujer blanca_1.png",
						"moreno": "res://Personaje/cabeza mujer morena_1.png",
						"monstrificado1": "res://Personaje/Monstrificados/mbm1_1.png",
						"monstrificado2": "res://Personaje/Monstrificados/mbm2_1.png"
					}
				},
			}
		},
		"cicla":{
			"casual":{
				"pierna_atras": "res://Personaje/avatar_montando_bici/pierna 05_1.png",
				"pierna_adelante": "res://Personaje/avatar_montando_bici/pierna 05.png",
				"pantorrilla_atras": "res://Personaje/avatar_montando_bici/pantorilla 05_1.png",
				"pantorrilla_adelante": "res://Personaje/avatar_montando_bici/pantorilla 05.png",
				"tronco": "res://Personaje/avatar_montando_bici/tronco 02 casual.png",
				"brazo": {
					"blanco":"res://Personaje/avatar_montando_bici/brazo 03.png",
					"moreno":"res://Personaje/avatar_montando_bici/brazo 03.png",
					"negro":"res://Personaje/avatar_montando_bici/brazo 03.png"
				},
				"antebrazo": {
					"blanco":"res://Personaje/avatar_montando_bici/antebrazo 03.png",
					"moreno":"res://Personaje/avatar_montando_bici/antebrazo 03_1.png",
					"negro":"res://Personaje/avatar_montando_bici/antebrazo 03_2.png"
				},
				"zapato": "res://Personaje/avatar_montando_bici/zapato 01.png",
			},
			"formal":{
				"pierna_atras": {
					"negro": "res://Personaje/avatar_montando_bici/pierna 06.png",
					"moreno": "res://Personaje/avatar_montando_bici/pierna 06_2.png",
					"blanco": "res://Personaje/avatar_montando_bici/pierna 06_4.png"
				},
				"pierna_adelante": {
					"negro": "res://Personaje/avatar_montando_bici/pierna 06_1.png",
					"moreno": "res://Personaje/avatar_montando_bici/pierna 06_3.png",
					"blanco": "res://Personaje/avatar_montando_bici/pierna 06_5.png"
				},
				"pantorrilla_atras": {
					"negro": "res://Personaje/avatar_montando_bici/pantorilla 06.png",
					"moreno": "res://Personaje/avatar_montando_bici/pantorilla 06_2.png",
					"blanco": "res://Personaje/avatar_montando_bici/pantorilla 06_4.png"
				},
				"pantorrilla_adelante": {
					"negro": "res://Personaje/avatar_montando_bici/pantorilla 06_1.png",
					"moreno": "res://Personaje/avatar_montando_bici/pantorilla 06_3.png",
					"blanco": "res://Personaje/avatar_montando_bici/pantorilla 06_5.png"
				},
				"tronco": "res://Personaje/avatar_montando_bici/tronco 02 formal.png",
				"brazo": {
					"blanco":"res://Personaje/avatar_montando_bici/brazo 01_1.png",
					"moreno":"res://Personaje/avatar_montando_bici/brazo 01_1.png",
					"negro":"res://Personaje/avatar_montando_bici/brazo 01_1.png"
				},
				"antebrazo": {
					"blanco":"res://Personaje/avatar_montando_bici/antebrazo 01_3.png",
					"moreno":"res://Personaje/avatar_montando_bici/antebrazo 01_2.png",
					"negro":"res://Personaje/avatar_montando_bici/antebrazo 01_1.png"
				},
				"zapato": "res://Personaje/avatar_montando_bici/zapato tacon.png",
			},
			"deportivo":{
				"pierna_atras": "res://Personaje/avatar_montando_bici/pierna 04_1.png",
				"pierna_adelante": "res://Personaje/avatar_montando_bici/pierna 04.png",
				"pantorrilla_atras": "res://Personaje/avatar_montando_bici/pantorilla 04_1.png",
				"pantorrilla_adelante": "res://Personaje/avatar_montando_bici/pantorilla 04.png",
				"tronco": "res://Personaje/avatar_montando_bici/tronco 02 deportivo.png",
				"brazo": {
					"blanco":"res://Personaje/avatar_montando_bici/brazo 02.png",
					"moreno":"res://Personaje/avatar_montando_bici/brazo 02.png",
					"negro":"res://Personaje/avatar_montando_bici/brazo 02.png"
				},
				"antebrazo": {
					"blanco":"res://Personaje/avatar_montando_bici/antebrazo 02.png",
					"moreno":"res://Personaje/avatar_montando_bici/antebrazo 02_1.png",
					"negro":"res://Personaje/avatar_montando_bici/antebrazo 02_2.png"
				},
				"zapato": "res://Personaje/avatar_montando_bici/zapato deportivo_1.png",
			},
			"cabeza":{
				"mounstruo":"res://Personaje/avatar_montando_bici/cabeza 11 hm_4.png",
				"peinado1":{
					"rubio":{
						"negro": "res://Personaje/avatar_montando_bici/cabeza 19 mnm_4.png",
						"blanco": "res://Personaje/avatar_montando_bici/cabeza 14 mbm_5.png",
						"moreno": "res://Personaje/avatar_montando_bici/cabeza 16 mmm_5.png",
						"monstrificado1": "res://Personaje/avatar_montando_bici/cabeza 20 mm_5.png",
						"monstrificado2": "res://Personaje/avatar_montando_bici/cabeza 21 mm_4.png"
					},
					"castano":{
						"negro": "res://Personaje/avatar_montando_bici/cabeza 18 mnc_5.png",
						"blanco": "res://Personaje/avatar_montando_bici/cabeza 13 mbc_4.png",
						"moreno": "res://Personaje/avatar_montando_bici/cabeza 15 mmc_5.png",
						"monstrificado1": "res://Personaje/avatar_montando_bici/cabeza 20 mc_4.png",
						"monstrificado2": "res://Personaje/avatar_montando_bici/cabeza 21 mc_4.png"
					},
					"negro":{
						"negro": "res://Personaje/avatar_montando_bici/cabeza 17 mnn_5.png",
						"blanco": "res://Personaje/avatar_montando_bici/cabeza 12 mb_5.png",
						"moreno": "res://Personaje/avatar_montando_bici/cabeza 15 mmn_5.png",
						"monstrificado1": "res://Personaje/avatar_montando_bici/cabeza 20 m_5.png",
						"monstrificado2": "res://Personaje/avatar_montando_bici/cabeza 21 mn_5.png"
					}
				},
				"peinado2":{
					"rubio":{
						"negro": "res://Personaje/avatar_montando_bici/cabeza 19 mnm_5.png",
						"blanco": "res://Personaje/avatar_montando_bici/cabeza 14 mbm_1.png",
						"moreno": "res://Personaje/avatar_montando_bici/cabeza 16 mmm_1.png",
						"monstrificado1": "res://Personaje/avatar_montando_bici/cabeza 20 mm_2.png",
						"monstrificado2": "res://Personaje/avatar_montando_bici/cabeza 20 mm_1.png"
					},
					"castano":{
						"negro": "res://Personaje/avatar_montando_bici/cabeza 18 mnc_1.png",
						"blanco": "res://Personaje/avatar_montando_bici/cabeza 13 mbc_1.png",
						"moreno": "res://Personaje/avatar_montando_bici/cabeza 15 mmc_1.png",
						"monstrificado1": "res://Personaje/avatar_montando_bici/cabeza 20 mc_1.png",
						"monstrificado2": "res://Personaje/avatar_montando_bici/cabeza 21 mc_1.png"
					},
					"negro":{
						"negro": "res://Personaje/avatar_montando_bici/cabeza 17 mnn_1.png",
						"blanco": "res://Personaje/avatar_montando_bici/cabeza 12 mb_1.png",
						"moreno": "res://Personaje/avatar_montando_bici/cabeza 15 mmn_1.png",
						"monstrificado1": "res://Personaje/avatar_montando_bici/cabeza 20 m_1.png",
						"monstrificado2": "res://Personaje/avatar_montando_bici/cabeza 21 mn_1.png"
					}
				},
				"peinado3":{
					"rubio":{
						"negro": "res://Personaje/avatar_montando_bici/cabeza 19 mnm_1.png",
						"blanco": "res://Personaje/avatar_montando_bici/cabeza 14 mbm_2.png",
						"moreno": "res://Personaje/avatar_montando_bici/cabeza 16 mmm_2.png",
						"monstrificado1": "res://Personaje/avatar_montando_bici/cabeza 20 mm_2.png",
						"monstrificado2": "res://Personaje/avatar_montando_bici/cabeza 21 mm_2.png"
					},
					"castano":{
						"negro": "res://Personaje/avatar_montando_bici/cabeza 18 mnc_2.png",
						"blanco": "res://Personaje/avatar_montando_bici/cabeza 13 mbc_2.png",
						"moreno": "res://Personaje/avatar_montando_bici/cabeza 15 mmc_2.png",
						"monstrificado1": "res://Personaje/avatar_montando_bici/cabeza 20 mc_2.png",
						"monstrificado2": "res://Personaje/avatar_montando_bici/cabeza 21 mc_2.png"
					},
					"negro":{
						"negro": "res://Personaje/avatar_montando_bici/cabeza 17 mnn_2.png",
						"blanco": "res://Personaje/avatar_montando_bici/cabeza 12 mb_2.png",
						"moreno": "res://Personaje/avatar_montando_bici/cabeza 15 mmn_2.png",
						"monstrificado1": "res://Personaje/avatar_montando_bici/cabeza 20 m_2.png",
						"monstrificado2": "res://Personaje/avatar_montando_bici/cabeza 21 mn_2.png"
					}
				}
			}
		}
	}
}

func _ready():
	load_game()

func save_game():
	var save_game = File.new()
	save_game.open("user://preferences.save", File.WRITE)
	var data = serialize()
#	var data = params_avatar
	save_game.store_line(to_json(data))
	save_game.close()

func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://preferences.save"):
		return # Error! We don't have a save to load.
	save_game.open("user://preferences.save", File.READ)
	var preferences = parse_json(save_game.get_line())
	params_avatar = preferences.params_avatar
	tutorial = preferences.tutorial

func serialize():
	var save_dict = {
		"params_avatar":params_avatar,
		"tutorial":tutorial
	}
	return save_dict

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		save_game()
		get_tree().quit()

func get_mins(tiempo_segs):
	var mins = tiempo_segs/60
	if mins < 10 : 
		mins = str("0",mins)
	return mins

func get_secs(tiempo_segs):
	print(tiempo_segs)
	var segs = tiempo_segs%60
	if segs < 10 : 
		segs = str("0",segs)
	return segs

func tiempo_en_reloj(t):
	return str(get_mins(t),":",get_secs(t))
	
func get_random_pitch_scale():
	var pitch_scale = randf()*0.4
	return 0.8 + pitch_scale
