Class {
	#name : #BaselineOfPenfeld,
	#superclass : #BaselineOf,
	#category : #BaselineOfPenfeld
}

{ #category : #baselines }
BaselineOfPenfeld >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ "Bloc"
			spec
				baseline: 'Bloc'
				with: [ spec repository: 'github://pharo-graphics/Bloc/src' ].
			
			"Brick text editor"
			spec
				baseline: 'Brick'
				with: [ spec repository: 'github://StevenCostiou/Brick/src' ].

			"PharoStylesheet"
			spec
				baseline: 'PharoStylesheet'
				with: [ spec repository: 'github://GlennCavarle/PharoStylesheet/src' ].

			"Penfeld"
			spec
				package: 'Penfeld'
				with: [ spec requires: #('PharoStylesheet' 'Bloc') ].
			spec package: 'Penfeld-Tests' with: [ spec requires: 'Penfeld' ].
			spec package: 'Penfeld-Bloc' with: [ spec requires: 'Penfeld' ].
			spec
				package: 'Penfeld-Bloc-Tests'
				with: [ spec requires: 'Penfeld-Bloc' ].
			spec package: 'Penfeld-Tests' with: [ spec requires: 'Penfeld' ] ]
]
