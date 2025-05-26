
# Desafio - Extração de Moedas (AwesomeAPI)

## 💡 Descripcion

Script para extraccion, trasnformacion y almacenamiento de cotizaciones de moendas (USD/BRL, EUR/BRL, BTC/BRL) via [AwesomeAPI](https://docs.awesomeapi.com.br/api-de-moedas).

## 🚀 Como ejecutar

1. Instale los requisitos (Python 3.x):

```bash
pip install requests

python extracao_moedas.py
```

📁 Arquivos gerados
dados_moedas.csv: Contiene los datos normalizados.

moedas.db: Banco de datos SQLite con las cotizaciones.

## 🛠 Tecnologias
Python 3

Biblioteca requests

SQLite (opcional)

CSV

## 📅 Formato de los datos
Campo	Descripcion
moeda_base	Codigo de moneda base (ej: USD)
moeda_destino	Codigo da moneda destino (ej: BRL)
valor_compra	Valor de compra de moneda
valor_venda	Valor de venta da moneda
data_hora	Fecha/hora UTC no formato yyyy-MM-dd HH:mm:ss
