Class {
	#name : #PenBlocContainerDresser,
	#superclass : #PenBlocDresser,
	#traits : 'TPenBlocBackgroundStyle + TPenBlocBorderStyle + TPenBlocMarginStyle + TPenBlocSizeStyle',
	#classTraits : 'TPenBlocBackgroundStyle classTrait + TPenBlocBorderStyle classTrait + TPenBlocMarginStyle classTrait + TPenBlocSizeStyle classTrait',
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #dressing }
PenBlocContainerDresser >> addElement: anElement [
	self component engineElement addChild: anElement engineElement
	
]

{ #category : #dressing }
PenBlocContainerDresser >> addElement: anElement at: anIndex [
	self component engineElement addChild: anElement engineElement at: anIndex + 1
]

{ #category : #dressing }
PenBlocContainerDresser >> doAfterApplyStyle [
	| var |

	"Position"
	var := self component position.
	var ifNotNil: [ self component engineElement relocate: var ].

	"Width and Height"
	self component engineElement constraintsDo: [ :c |
		self component width ifNotNil: [ c horizontal exact: self component width pref ].
		self component height ifNotNil: [ c vertical exact: self component height pref ] 
	]
]

{ #category : #initialization }
PenBlocContainerDresser >> initEngineElement [
	| element |
	self component engineElement: BlElement new.
	element := self component engineElement.
	
	element layout: (self component layout isLinear
		ifTrue: [ self component layout isHorizontal 
			ifTrue: [ BlLinearLayout horizontal ]
			ifFalse: [ BlLinearLayout vertical ]]
		ifFalse: [ self component layout isAbsolute
			ifTrue: [ BlBasicLayout new ]
			ifFalse: [ BlFlowLayout new ]
		]
	).
		
	self component engineElement constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent
	].
]

{ #category : #dressing }
PenBlocContainerDresser >> removeElement: anElement [
	self component engineElement removeChild: anElement engineElement
	
]
