# Description
[![CIMatrix](https://github.com/pharo-ai/Datasets/actions/workflows/cimatrix.yml/badge.svg)](https://github.com/pharo-ai/Datasets/actions/workflows/cimatrix.yml)

Contains Natural Language Processing (NLP) objects for Pharo.

## Installation

To install `nlp`, go to the Playground (`Ctrl+OW`) in your [Pharo](https://pharo.org/) image and execute the following Metacello script (select it and press Do-it button or `Ctrl+D`):

```smalltalk
Metacello new
  baseline: 'AINLP';
  repository: 'github://pharo-ai/nlp/src';
  load.
```

## If you want to depend on it

```smalltalk
spec 
   baseline: 'AIDatasets' 
   with: [ spec repository: 'github://pharo-ai/nlp/src' ].
```

## Usage

WiP
