# Penfeld

Penfeld is an User-Interface (UI) definition model framework for Pharo.
Main principe of Penfeld is to be apart of UI technologies or engine.

Penfeld provide instanciation of his model to some supported UI engine in Pharo (as Bloc, etc.) based on standard UI customization (as CSS, SVG, etc.).

## Getting Started

### Installing Penfeld

```Smalltalk
Metacello new
   baseline: 'Penfeld';
   repository: 'github://OpenSmock/Penfeld/src';
   load
```
### Examples

See `Penfeld-Bloc-Tests` or execute `PenExamplesViewer>>#open`.

## Credits

* **Alain Plantec** - *Initial work* - [plantec](https://github.com/plantec)
* **Nolwenn Fournier** - *Initial work* - [nolwennfournier](https://github.com/nolwennfournier)
* **Eric Le Pors** - *Initial work* - [ELePors](https://github.com/ELePors)
* **Pierre Laborde** - *Initial work* - [labordep](https://github.com/labordep)
* **Steven Costiou** - *Initial work* - [StevenCostiou](https://github.com/StevenCostiou)
* **Glenn** - *Pharo Stylesheet* - [GlennCavarle](https://github.com/GlennCavarle)

## License

This project is licensed under the MIT License.
