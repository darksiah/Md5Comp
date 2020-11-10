#!/bin/bash

./comparar.sh $1 $2

cp comparativa.json static/data/data.json

source venv/bin/activate

python main.py

deactivate

rm comparativa.csv comparativa.json
