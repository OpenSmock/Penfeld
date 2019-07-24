Class {
	#name : #PenBlocImageDresser,
	#superclass : #PenBlocDresser,
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #dressing }
PenBlocImageDresser >> doAfterApplyStyle [ 
	| var element |
	element := self component engineElement.

	"Position"
	var := self component position.
	var ifNotNil: [ element relocate: var ].

	"Width"
	var := self component form width.
	var ifNotNil: [ element constraintsDo: [ :c | c horizontal exact: var ]].
	
	"Height"
	var := self component form height.
	var ifNotNil: [ element constraintsDo: [ :c | c vertical exact: var ]].
]

{ #category : #dressing }
PenBlocImageDresser >> initEngineElement [
	self component engineElement: (BlElement new background: self component form asBlBackground).
	self component engineElement preventMeAndChildrenMouseEvents.
]
