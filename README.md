# General Purpose Neural Network [![Build Status](https://travis-ci.org/jazcarate/ia-neural.svg?branch=master)](https://travis-ci.org/jazcarate/ia-neural)

Neural Network to compute stuff

#Uso

- `$ crystal run src/generate.cr` Para generar la data para entrenar a la red neuronal
- `$ crystal run src/learn.cr` para aprender
- `$ crystal run src/predict.cr -- 0.0,0.0,0.1 -e 0.0` para chekear que un dato `[0.0, 0.0, 0.1]` contra `0.0`

## Installation

Tener crystal. [Guía de instalación](https://crystal-lang.org/docs/installation/index.html)
