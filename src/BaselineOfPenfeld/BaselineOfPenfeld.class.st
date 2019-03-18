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
			"Packages"
			spec package: 'Penfeld'.
			spec package: 'Penfeld-Tests' with: [ spec requires: 'Penfeld' ].
		]
]
