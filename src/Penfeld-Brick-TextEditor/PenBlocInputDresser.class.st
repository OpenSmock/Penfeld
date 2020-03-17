Class {
	#name : #PenBlocInputDresser,
	#superclass : #PenBlocDresser,
	#instVars : [
		'dataSource',
		'ropedText'
	],
	#category : #'Penfeld-Brick-TextEditor-Dressers'
}

{ #category : #accessing }
PenBlocInputDresser >> dataSource [
	^ dataSource
]

{ #category : #dressing }
PenBlocInputDresser >> doAfterApplyStyle [
	| var |

	"Position"
	var := self component position.
	var ifNotNil: [ self component engineElement relocate: var ].

	"Width"
	var := self component width.
	var ifNotNil: [ self component engineElement constraintsDo: 
		[ :c | c horizontal exact: var pref ] 
	].

	"Height"
	var := self component height.
	var ifNotNil: [ self component engineElement constraintsDo: 
		[ :c | c vertical exact: var pref ] 
	].

	"Apply roped text"
	self dataSource text: ropedText 
]

{ #category : #dressing }
PenBlocInputDresser >> doBeforeApplyStyle [ 
	ropedText := self component text asRopedText
]

{ #category : #dressing }
PenBlocInputDresser >> initEngineElement [
	
	self component engineElement: BrEditorElement new.	
	dataSource := BrTextEditor new.
	
	self component engineElement editor: dataSource.
	dataSource 
		when: BrTextEditorInsertedEvent 
		do: [ :e | self component text: dataSource text copy ].
	dataSource
		when: BrTextEditorDeletedEvent
		do: [ :e | self component text: dataSource text copy ].
]

{ #category : #'accessing - font' }
PenBlocInputDresser >> ropedText [
	^ ropedText
]
