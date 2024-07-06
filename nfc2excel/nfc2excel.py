import serial
import serial.tools.list_ports
import openpyxl
from openpyxl import Workbook
from datetime import datetime

# Función para detectar el puerto COM
def find_arduino():
    ports = list(serial.tools.list_ports.comports())
    for port in ports:
        if "CH340" in port.description:
            return port.device
    return None

# Detectar el puerto COM del Arduino
com_port = find_arduino()
if not com_port:
    print("No se pudo encontrar un Arduino conectado.")

# Configuración del puerto serial
ser = serial.Serial(com_port, 115200)  # Usar el puerto detectado automáticamente

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

# Preguntar al usuario a partir de qué índice comenzar a contar
start_index = int(input("Ingrese el índice inicial: "))

# Inicializar el índice de la tarjeta
index = start_index

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
