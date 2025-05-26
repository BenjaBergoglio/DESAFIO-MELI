# extracao_moedas.py

import requests # type: ignore
import csv
from datetime import datetime, timezone
import sqlite3

# Definir pares de monedas
PAIRS = ['USD-BRL', 'EUR-BRL', 'BTC-BRL']
URL = f'https://economia.awesomeapi.com.br/last/{",".join(PAIRS)}'

# Obtener datos de la API
response = requests.get(URL)
data = response.json()

# Transformar y normalizar
registros = []
for pair in PAIRS:
    dados = data[pair.replace("-", "")]
    moeda_base = dados["code"]
    moeda_destino = dados["codein"]
    valor_compra = dados["bid"]
    valor_venda = dados["ask"]
    timestamp = int(dados["timestamp"])
    data_hora = datetime.fromtimestamp(timestamp, tz=timezone.utc).strftime('%Y-%m-%d %H:%M:%S')

    registros.append({
        "moeda_base": moeda_base,
        "moeda_destino": moeda_destino,
        "valor_compra": valor_compra,
        "valor_venda": valor_venda,
        "data_hora": data_hora
    })

# Guardar en archivo CSV
csv_file = 'datos_monedas.csv'
with open(csv_file, mode='w', newline='', encoding='utf-8') as file:
    writer = csv.DictWriter(file, fieldnames=registros[0].keys())
    writer.writeheader()
    writer.writerows(registros)

print(f'Datos guardados en {csv_file}')


# (Opcional) Guardar en SQL
def salvar_em_sqlite(registros):
    conn = sqlite3.connect('moedas.db')
    cursor = conn.cursor()

    cursor.execute('''
        CREATE TABLE IF NOT EXISTS cotacoes (
            moeda_base TEXT,
            moeda_destino TEXT,
            valor_compra REAL,
            valor_venda REAL,
            data_hora TEXT
        )
    ''')

    for reg in registros:
        cursor.execute('''
            INSERT INTO cotacoes (moeda_base, moeda_destino, valor_compra, valor_venda, data_hora)
            VALUES (?, ?, ?, ?, ?)
        ''', (reg["moeda_base"], reg["moeda_destino"], reg["valor_compra"], reg["valor_venda"], reg["data_hora"]))

    conn.commit()
    conn.close()
    print('Datos guardados en moedas.db')
