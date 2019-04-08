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
			"Bloc"
			spec baseline: 'Bloc'	with:	[ spec repository: 'github://pharo-graphics/Bloc/src' ].

			"PetitParser"
			spec baseline: 'PetitParser' with: [ spec repository: 'github://moosetechnology/PetitParser/src' ].
							
			"Penfeld"
			spec package: 'Penfeld-Style' with: [ spec requires: 'PetitParser' ].
			spec package: 'Penfeld' with: [ spec requires: #('Penfeld-Style' 'Bloc') ].
			spec package: 'Penfeld-Tests' with: [ spec requires: 'Penfeld' ].
			spec package: 'Penfeld-Bloc' with: [ spec requires: 'Penfeld' ].
			spec package: 'Penfeld-Bloc-Tests' with: [ spec requires: 'Penfeld-Bloc' ].
			spec package: 'Penfeld-Tests' with: [ spec requires: 'Penfeld' ] ]
]
