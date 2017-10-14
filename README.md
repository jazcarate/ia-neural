# General Purpose Neural Network [![Build Status](https://travis-ci.org/jazcarate/ia-neural.svg?branch=master)](https://travis-ci.org/jazcarate/ia-neural)

Neural Network to compute stuff

#Uso

- `$ crystal run src/generate.cr` Para generar la data para entrenar a la red neuronal
- `$ crystal run src/learn.cr` para aprender
- `$ crystal run src/predict.cr -- ./out/weights_data.yaml "{\"data\": [0.0, 0.0, 1.0]}" 0.0` para chekear que un dato

## Installation

Tener crystal. [Guía de instalación](https://crystal-lang.org/docs/installation/index.html)
