Class {
	#name : #BaselineOfPenfeldCore,
	#superclass : #BaselineOf,
	#category : #BaselineOfPenfeldCore
}

{ #category : #dependencies }
BaselineOfPenfeldCore >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			
			"Dependencies for Pharo 8"
			spec for: #'pharo8.x'do: [ 
				self geometry: spec.
			].
			
			self stylesheet: spec.

			"Penfeld"
			spec
				package: 'Penfeld'
				with: [ spec requires: #('PharoStylesheet' 'Geometry') ].
			spec package: 'Penfeld-Tests' with: [ spec requires: 'Penfeld' ] ]
]

{ #category : #dependencies }
BaselineOfPenfeldCore >> geometry: spec [
	spec
		baseline: 'Geometry'
		with: [ spec repository: 'github://TelescopeSt/Geometry/src' ]
]

{ #category : #dependencies }
BaselineOfPenfeldCore >> stylesheet: spec [
	spec
		baseline: 'PharoStylesheet'
		with: [ spec repository: 'github://OpenSmock/PharoStylesheet/src' ]
]
