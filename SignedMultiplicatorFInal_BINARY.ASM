Data_A:		0x00				; Data_A inicializado en 0
Q:			0x03				; Valor de Q
M:			0x07				; valor de M
Q1:			0X00 				; Q-1 inicializado en 0
Count:		0x08				; Valor de Count conforme el número de bits
INIT_IF:	
			10111				; Cargar el valor de Q al ACC
			Q					
			00100
			10000				; Hacer AND de Q con 1 para enmasacara el último bit
			0x01				; El valor de Q enmascarado queda en ACC
			00010				; Cargar el valor del LSB de Q a A
			10111				; Cargar la dirección de Q-1 en ACC
			Q1
			00100				; Cargar el valor de Q-1 en ACC
			10001 				; PARA SABER SI ES 11 O 00 (OBVIAMENTE GENERA FLAG)!!
			01011				; Realizamos el Shift directamente
			SHIFT_QM1 			
			00001				; Aqui se verifica si es el caso 10 O 01
			01011
			SUM_01
DIF_10:		10111				; Cargar el dirección de M al ACC
			M					; Dirección de M
			00100				; Cargar el valor de M al registro M
			00010				; Treaer el valor del ACC al A
			10111				; Cargar el dirección de Data_A al ACC
			Data_A				; Dirección de Data_A
			00100				; Cargar el valor de Data_A
			10010 				; A-M 
			00110 				; GUARDAR EN MEMORIA A-M en Data_A			
			01010
			ARIT_SHFT
SUM_01:		10111				; Cargar el dirección de M al ACC
			M					; Dirección de M
			00100				; Cargar el valor de M al registro M
			00010				; Treaer el valor del ACC al A
			10111				; Cargar el dirección de Data_A al ACC
			Data_A				; Dirección de Data_A
			00100				; Cargar el valor de Data_A
			01001 				; A+M 
			00110 				; GUARDAR EN MEMORIA A+M en Data_A
ARIT_SHFT:	10111				; Cargar el dirección de Q al ACC
			Q					; Dirección de Q
			00100				; Cargar el valor de Q al registro ACC
			10110				; Hacer AND de Q con 1 para enmasacara el LSB
			0x01				; El valor de Q enmascarado queda en ACC
			10111				; Cargar el dirección de Q1 al ACC
			Q1					; Dirección de Q1
			00110 				;	 Guardar en memoria el valor final de Q1
			10111				; Cargar la dirección de Q al ACC
			Q					; Dirección de Q
			00100				; Cargar el valor de Q al registro ACC
			10011				; Se aplica el shift lógico para desplazar los bits a la derecha
			00110 				; Guardar en memoria el valor final de Q desplazado
			10111				; Cargar el dirección de A al ACC
			Data_A				; Dirección de Data_A
			00100				; Cargar el valor de Data_A al ACC
			10110				; Hacer AND de A con 1 para enmasacara el LSB (OBVIAMENTE GENERA FLAG)!!
			0x01				; El valor de Data_A enmascarado queda en ACC
			01011
			A_MSB
			10111				; Cargar el dirección de Q al ACC
			Q					; Dirección de Q
			00100				; Cargar el valor de Q al registro ACC
			10100				; Hacer OR de Q con 0x80 para concatenar el LSB de Data_A
			0x80				; El valor de Q enmascarado queda en ACC
			00110 				; Guardar en memoria el valor final de Q desplazado
A_MSB:		10111				; Cargar el dirección de Data_A al ACC
			Data_A				; Dirección de A
			00100				; Cargar el valor de Data_A al ACC
			00010				; Copiar ACC en A para la comparacion
			10110				; Hacer AND de A con 1 para enmasacara el último bit (OBVIAMENTE GENERA FLAG)
			0x80				; El valor de Data_A enmascarado queda en ACC
			10101				; Cambiamos el valor de A con el valor del ACC
			10011				; Desplazamos el ACC a la derecha
			10100				; Agregamos con un OR el Bit 1 MSB con Data_A desplazado
			00110 				; Guardar en memoria el valor final de Data_A desplazado
COUNT_ACT:	00011				; Cargar el dirección de Count al ACC
			Count				; Dirección de Count
			00101				; Mover la dirección de Count al DPTR
			00100				; Cargar el valor de Count al registro Count
			10110 
			0xFF				; Decremento de Count en 1
			00110				; Actualizar el valor de Count y guardarlo en su Registro
IF_OVER:	00010				; Restar para activar la bandera de SUB
			01011				; Si el flag es 1, Count ha llegado a 0, ejecutafin del programa
			FIN					
			01010				; Si el flag es 0, Count no ha llegado a 0, ejecuta de nuevo desde INIT_IF
			INIT_IF
FIN:		10111				; Cargar el dirección de Data_A al ACC
			Data_A				; Dirección de A
			00100				; Cargar el valor de Data_A al ACC
			00010				; Copiar ACC en A para la comparacion
			10111				; Cargar el dirección de Q al ACC
			Q					; Dirección de Q
			00100
			HALT