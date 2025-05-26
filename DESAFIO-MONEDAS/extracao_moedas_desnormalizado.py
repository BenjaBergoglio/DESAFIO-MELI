import requests
import csv

# Pares de monedas a consultar
PAIRS = ['USD-BRL', 'EUR-BRL', 'BTC-BRL']
URL = f'https://economia.awesomeapi.com.br/last/{",".join(PAIRS)}'

# Hacemos la solicitud a la API
response = requests.get(URL)
data = response.json()

# Lista donde vamos a guardar los datos desnormalizados
datos_desnormalizados = []

# Procesamos cada par de moneda
for par in PAIRS:
    clave = par.replace("-", "")
    item = data[clave]

    # Extraemos todos los campos relevantes del JSON
    datos_desnormalizados.append({
        "code": item.get("code"),
        "codein": item.get("codein"),
        "name": item.get("name"),
        "high": item.get("high"),
        "low": item.get("low"),
        "varBid": item.get("varBid"),
        "pctChange": item.get("pctChange"),
        "bid": item.get("bid"),
        "ask": item.get("ask"),
        "timestamp": item.get("timestamp"),
        "create_date": item.get("create_date")
    })

# Guardamos el archivo CSV desnormalizado
with open("datos_monedas_desnormalizado.csv", mode='w', newline='', encoding='utf-8') as archivo:
    escritor = csv.DictWriter(archivo, fieldnames=datos_desnormalizados[0].keys())
    escritor.writeheader()
    escritor.writerows(datos_desnormalizados)

print("✅ Archivo 'datos_monedas_desnormalizado.csv' generado con éxito.")
