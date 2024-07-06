import serial
import openpyxl
from openpyxl import Workbook
from datetime import datetime

# Configuración del puerto serial
ser = serial.Serial('COM8', 115200)  # Cambia 'COM8' al puerto serial correspondiente

# Obtener la fecha y hora actuales
now = datetime.now()
timestamp = now.strftime("%Y%m%d_%H%M%S")

# Crear un nuevo archivo Excel con la fecha y hora en el nombre
filename = f"datos_nfc_{timestamp}.xlsx"
wb = Workbook()
ws = wb.active
ws.title = "Datos NFC"

# Añadir encabezados
ws.append(["Index", "UID"])

# Inicializar el índice de la tarjeta
index = 1

# Leer datos del puerto serial y escribir en Excel
try:
    while True:
        if ser.in_waiting > 0:
            uid = ser.readline().decode('utf-8').strip()
            print(f"Index: {index}, UID: {uid}")
            ws.append([index, uid])
            wb.save(filename)
            index += 1
except KeyboardInterrupt:
    print("Terminando la lectura de datos.")
    ser.close()
