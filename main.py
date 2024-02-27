import pandas as pd
from flask import Flask, jsonify
import json
import codecs

app = Flask(__name__)

# Загружаем данные из файла Excel
data = pd.read_excel('datakuzeg.xlsx')

def decode_unicode(data):
    for record in data:
        for key, value in record.items():
            record[key] = codecs.decode(value, 'unicode_escape')
    return data

@app.route('/')
def get_data():
    # Преобразуем данные в формат JSON и декодируем Unicode в слова
    decoded_data = decode_unicode(data.to_dict(orient='records'))
    return jsonify(decoded_data)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)