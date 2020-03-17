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
		do: [
			self geometry: spec.
			self stylesheet: spec.
			self bloc: spec.

			"Penfeld"
			spec
				package: 'Penfeld'
				with: [ spec requires: #('PharoStylesheet' 'Bloc') ].
			spec package: 'Penfeld-Tests' with: [ spec requires: 'Penfeld' ].
			spec package: 'Penfeld-Bloc' with: [ spec requires: 'Penfeld' ].
			spec package: 'Penfeld-Brick-TextEditor' with: [ spec requires: 'Penfeld-Bloc' ].
			spec
				package: 'Penfeld-Bloc-Tests'
				with: [ spec requires: 'Penfeld-Bloc' ].
			spec package: 'Penfeld-Tests' with: [ spec requires: 'Penfeld' ] ]
]

{ #category : #dependencies }
BaselineOfPenfeld >> bloc: spec [
	spec
		baseline: 'Bloc'
		with: [ spec repository: 'github://feenkcom/Bloc/src' ].
		
	"Brick text editor"
	spec
		baseline: 'Brick'
		with: [ spec repository: 'github://StevenCostiou/Brick/src'. ].
]

{ #category : #dependencies }
BaselineOfPenfeld >> geometry: spec [
	spec
		baseline: 'Geometry'
		with: [ spec repository: 'github://TelescopeSt/Geometry/src' ]
]

{ #category : #dependencies }
BaselineOfPenfeld >> stylesheet: spec [
	spec
		baseline: 'PharoStylesheet'
		with: [ spec repository: 'github://OpenSmock/PharoStylesheet/src' ]
]
