Class {
	#name : #PenBlocListDresser,
	#superclass : #PenBlocDresser,
	#instVars : [
		'dataSource',
		'pushedItem'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #dressing }
PenBlocListDresser >> initEngineElementFor: aComponent [
	| list |
	dataSource := PenInfiniteDataSource new.
	aComponent engineElement: PenInfiniteListElement new.
	aComponent engineElement constraintsDo: [:c |
		c horizontal matchParent.
		c vertical matchParent]. 
	
	list := aComponent items collect: [ :item | 
		item engineElement 
			constraintsDo: [ :c | c horizontal matchParent ];
			yourself ].
	dataSource elements: list.
	aComponent engineElement dataSource: dataSource.
	
	aComponent allowToSelect ifFalse: [ ^ self ].

	pushedItem := false.
	aComponent items do: [ :item |
		item engineElement when: BlMouseDownEvent do: [ :e | self whenMouseDownEventOn: item ].
		item engineElement when: BlMouseUpEvent do: [ :e | self whenMouseUpEventOn: item ].
		item engineElement when: BlMouseLeaveEvent do: [ :e | self whenMouseLeaveEventOn: item ].].
]

{ #category : #dressing }
PenBlocListDresser >> whenMouseDownEventOn: anItem [ 
	anItem activatePseudoClass: #active.
	anItem refresh.
	pushedItem := anItem.
]

{ #category : #dressing }
PenBlocListDresser >> whenMouseLeaveEventOn: anItem [
	pushedItem = anItem ifFalse: [ ^ self ].
	anItem deactivatePseudoClass: #active.
	anItem refresh.
	pushedItem := nil.
]

{ #category : #dressing }
PenBlocListDresser >> whenMouseUpEventOn: anItem [
	(pushedItem notNil and: [anItem = pushedItem]) ifTrue: [
		pushedItem deactivatePseudoClass: #active.
		pushedItem refresh.
		pushedItem := nil].
]
