# 🪙 Extracción de cotizaciones de monedas – AwesomeAPI

Este proyecto realiza la **extracción y desnormalización de cotizaciones de monedas** desde la API pública de [AwesomeAPI](https://docs.awesomeapi.com.br/api-de-moedas), utilizando Python.

---

## ✅ Objetivo

Consumir los datos de cotización de las siguientes monedas frente al real brasileño (BRL):

- USD/BRL (dólar estadounidense)
- EUR/BRL (euro)
- BTC/BRL (bitcoin)

Y guardar los datos **desnormalizados** (todos los campos relevantes del JSON original) en un archivo `.csv`.

---

## 🛠️ Tecnologías utilizadas

- Python 3.x
- Librería `requests` (para consumir la API)
- Librería `csv` (para guardar los datos)

---

## 📦 Archivos generados

- `extracao_moedas.py` → Script principal
- `datos_monedas_desnormalizado.csv` → Archivo de salida con los datos desnormalizados

---

## 🧾 Estructura del CSV

El archivo generado (`datos_monedas_desnormalizado.csv`) contiene los siguientes campos:

| Campo         | Descripción                               |
|---------------|--------------------------------------------|
| `code`        | Código de la moneda base (ej. USD)         |
| `codein`      | Código de la moneda destino (BRL)          |
| `name`        | Nombre del par de monedas                  |
| `high`        | Valor máximo en el período                 |
| `low`         | Valor mínimo en el período                 |
| `varBid`      | Variación del valor de compra              |
| `pctChange`   | Porcentaje de variación                    |
| `bid`         | Valor de compra                            |
| `ask`         | Valor de venta                             |
| `timestamp`   | Timestamp en segundos                      |
| `create_date` | Fecha y hora de creación del dato          |

---

## ▶️ Cómo ejecutar el script

1. Asegurate de tener Python instalado.
2. Instalá la librería `requests` si no la tenés:

   ```bash
   pip install requests
