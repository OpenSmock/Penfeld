Class {
	#name : #PenBlocContainerDresser,
	#superclass : #PenBlocDresser,
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #dressing }
PenBlocContainerDresser >> addElement: anElement on: aComponent [
	aComponent engineElement addChild: anElement engineElement
	
]

{ #category : #dressing }
PenBlocContainerDresser >> addElement: anElement on: aComponent at: anIndex [
	aComponent engineElement addChild: anElement engineElement at: anIndex + 1
]

{ #category : #dressing }
PenBlocContainerDresser >> doAfterApplyStyleOn: aComponent [
	| var |

	"Position"
	var := aComponent position.
	var ifNotNil: [ aComponent engineElement relocate: var ].
]

{ #category : #initialization }
PenBlocContainerDresser >> initEngineElementFor: aComponent [
	| element |
	aComponent engineElement: BlElement new.
	element := aComponent engineElement.
	
	element layout: (aComponent layout isLinear
		ifTrue: [ aComponent layout isHorizontal 
			ifTrue: [ BlLinearLayout horizontal ]
			ifFalse: [ BlLinearLayout vertical ]]
		ifFalse: [ aComponent layout isAbsolute
			ifTrue: [ BlBasicLayout new ]
			ifFalse: [ BlFlowLayout new ]
		]
	).
		
	aComponent engineElement constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent
	].
]

{ #category : #dressing }
PenBlocContainerDresser >> removeElement: anElement on: aComponent [
	aComponent engineElement removeChild: anElement engineElement
	
]
