Class {
	#name : #PenBlocListExamples,
	#superclass : #Object,
	#category : #'Penfeld-Bloc-Examples'
}

{ #category : #examples }
PenBlocListExamples class >> exampleWithMultiselection [
	| model |
	model := PenList new addAllItems: 
		(Object withAllSubclasses collect: [ :c | PenLabel new 
			text: c name; 
			yourself ]) .
	model sortingBlock: [ :a :b | a text < b text ].
	model allowToSelect: true.
	model multiSelection: true.
	model dresser: PenBlocListDresser new.
	model openInInternalWindow
]

{ #category : #examples }
PenBlocListExamples class >> exampleWithNoDeselection [
	| model |
	model := PenList new addAllItems: 
		(Object withAllSubclasses collect: [ :c | PenLabel new 
			text: c name; 
			yourself ]) .
	model sortingBlock: [ :a :b | a text < b text ].
	model allowToSelect: true.
	model allowToDeselect: false.
	model dresser: PenBlocListDresser new.
	model openInInternalWindow
	
]

{ #category : #examples }
PenBlocListExamples class >> exampleWithSelection [
	| model |
	model := PenList new addAllItems: 
		(Object withAllSubclasses collect: [ :c | PenLabel new 
			text: c name; 
			yourself ]) .
	model onSelectionChangedDo: [ self inform: model selection printString  ].
	model sortingBlock: [ :a :b | a text < b text ].
	model allowToSelect: true.
	model dresser: PenBlocListDresser new.
	model openInInternalWindow
]

{ #category : #examples }
PenBlocListExamples class >> exampleWithoutSelection [
	| model |
	model := PenList new addAllItems: 
		(Object withAllSubclasses collect: [ :c | PenLabel new 
			text: c name;
			yourself]) .
	model sortingBlock: [ :a :b | a text < b text ].
	model dresser: PenBlocListDresser new.
	model openInInternalWindow
]

{ #category : #opening }
PenBlocListExamples class >> spaceBackground [
	^ Color r: 128 g: 128 b: 128 range: 255
]

{ #category : #'see class side' }
PenBlocListExamples >> seeClassSide [
]
