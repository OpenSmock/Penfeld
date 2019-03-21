Class {
	#name : #PenTableSizer,
	#superclass : #Object,
	#instVars : [
		'sections'
	],
	#category : #'Penfeld-Experimental'
}

{ #category : #'as yet unclassified' }
PenTableSizer >> initSectionsSizeIn: aTableSize [
	| fixedSizeSections sizeRest sectionSize |
	fixedSizeSections := sections collect: [ sections resizable not ].
	sizeRest := aTableSize - (fixedSizeSections sum: [ :section | section size ]).
	self
		assert: sizeRest <= 0
		description: 'Cannot respect conditions in this table.'.
	sectionSize := sizeRest / (sections size - fixedSizeSections).
	sections do: [ :section | section resizable ifTrue: [ 
			section size: sectionSize ] ]
]

{ #category : #accessing }
PenTableSizer >> sections: aList [
	sections := aList
]
