			01010000
			INIT_IF
Data_A	:	0x00				; Data_A inicializado en 0
Q		:	0xFD				; Valor de Q
M		:	0x07				; valor de M
Q1		:	0X00 				; Q-1 inicializado en 0
Count	:	0x00				; Valor de Count conforme el número de bits
INIT_VAR:	010111000	; Inicializar Data_A
			Data_A		
			00011000
			0x00
			00110000
			010111000	; Inicializar Q-1
			Q1		
			00011000
			0x00
			00110000
			010111000	; Inicializar Count
			Count		
			00011000
			0x08
			00110000
INIT_IF:	010111000	; Traer Q
			Q					
			00100000
			00011000	; Hacer AND de Q con 1 para enmasacara el último bit
			0x01				; El valor de Q enmascarado queda en ACC
			00010000		; Cargar el valor del LSB de Q a A
			10111000	; Apuntar a la dirección de Q-1 con el DPTR-
			Q1
			00100000	; Cargar el valor de Q-1 en ACC
			10001000 		; PARA SABER SI ES 11 O 00 (OBVIAMENTE GENERA FLAG)!!
			01011000			; Realizamos el Shift directamente
			SHIFT_QM1 			
			00001000		; Aqui se verifica si es el caso 10 O 01
			01011000
			SUM_01
DIF_10:		10111000	; Apuntar a la dirección de M con el DPTR
			M					; Dirección de M
			00100000	; Cargar el valor de M al registro M
			00010000		; Treaer el valor del ACC al A
			10111000	; Apuntar a la dirección de Data_A con el DPTR
			Data_A				; Dirección de Data_A
			00100000	; Cargar el valor de Data_A
			10010000 		; A-M 
			00110000 ; GUARDAR EN MEMORIA A-M en Data_A			
			01010000
			ARIT_SHFT
SUM_01:		10111000	; Apuntar a la dirección de M con el DPTR
			M					; Dirección de M
			00100000	; Cargar el valor de M al registro M
			00010000		; Treaer el valor del ACC al A
			10111000	; Cargar el dirección de Data_A al ACC
			Data_A				; Dirección de Data_A
			00100000	; Cargar el valor de Data_A
			01001000 		; A+M 
			00110000 ; GUARDAR EN MEMORIA A+M en Data_A
ARIT_SHFT:	10111000	; Apuntar a la direccion de Q con el DPTR
			Q					; Dirección de Q
			00100000	; Cargar el valor de Q al registro ACC
			00011000	; Hacer AND de Q con 1 para enmasacara el LSB
			0x01				; El valor de Q enmascarado queda en ACC
			10111000	; Apuntar a la dirección Q1 con el DPTR
			Q1					; Dirección de Q1
			00110000 ; Guardar en memoria el valor final de Q1
			10111000	; Apuntar a Q con el DPTR
			Q					; Dirección de Q
			00100000	; Cargar el valor de Q al registro ACC
			10011000			; Se aplica el shift lógico para desplazar los bits a la derecha
			00110000 ; Guardar en memoria el valor final de Q desplazado
			10111000	; Apuntar a la dirección de A con el DPTR
			Data_A				; Dirección de Data_A
			00100000	; Cargar el valor de Data_A al ACC
			00011000	; Hacer AND de A con 1 para enmasacara el LSB (OBVIAMENTE GENERA FLAG)!!
			0x01				; El valor de Data_A enmascarado queda en ACC
			01011000
			A_MSB
			00011000	; Cargar el valor constante 0x80 para la comparación en ACC
			0x80
			00010000		; Guardar temporalmente el valor 0x80 en el registro A
			10111000	; Apuntar a la dirección de Q con el DPTR
			Q					; Dirección de Q
			00100000	; Cargar el valor de Q al registro ACC
			10100000		; Hacer OR de Q con 0x80 para concatenar el LSB de Data_A en el ACC
			00110000 ; Guardar en memoria el valor final de Q desplazado
A_MSB:		10111000	; Apuntar a la dirección de Data_A con el DPTR
			Data_A				; Dirección de A
			00100000	; Cargar el valor de Data_A al ACC
			00010000		; Copiar ACC en A para la comparacion
			00011000	; Hacer AND de A con 1 para enmasacara el último bit (OBVIAMENTE GENERA FLAG)
			0x80				; El valor de Data_A enmascarado queda en ACC
			10101000		; Cambiamos el valor de A con el valor del ACC
			10011000			; Desplazamos el ACC a la derecha
			10100000		; Agregamos con un OR el Bit 1 MSB con Data_A desplazado
			00110000 ; Guardar en memoria el valor final de Data_A desplazado
COUNT_ACT:	00011000	; Cargar el dirección de Count al ACC
			Count				; Dirección de Count
			00101000	; Mover la dirección de Count al DPTR
			00100000	; Cargar el valor de Count al registro Count
			10000000 
			0xFF				
			00110000	; Actualizar el valor de Count y guardarlo en su Registro
IF_OVER:	00010000		; Restar para activar la bandera de SUB
			01011000			; Si el flag es 1, Count ha llegado a 0, ejecutafin del programa
			FIN					
			01010000			; Si el flag es 0, Count no ha llegado a 0, ejecuta de nuevo desde INIT_IF
			INIT_IF
FIN:		10111000	; Apuntar a la dirección de Data_A con el DPTR
			Data_A				; Dirección de A
			00100000	; Cargar el valor de Data_A al ACC
			00010000		; Copiar ACC en A para la comparacion
			10111000	; Apuntae a la dirección de Q con el DPTR
			Q					; Dirección de Q
			00100000	; Cargar el valor de Q al registro ACC
			HALT
