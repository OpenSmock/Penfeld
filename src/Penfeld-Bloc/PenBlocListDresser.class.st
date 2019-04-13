Class {
	#name : #PenBlocListDresser,
	#superclass : #PenBlocDresser,
	#traits : 'TPenBlocBackgroundStyle',
	#classTraits : 'TPenBlocBackgroundStyle classTrait',
	#instVars : [
		'dataSource',
		'pushedItem'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #rendering }
PenBlocListDresser >> doAfterApplyStyle [ 
	| var |

	"Position"
	var := self model position.
	var ifNotNil: [ self model engineElement relocate: var ].

	"Width"
	var := self model width.
	var ifNotNil: [ self model engineElement width: var pref ].
	
	"Height"
	var := self model height.
	var ifNotNil: [ self model engineElement height: var pref ]
]

{ #category : #dressing }
PenBlocListDresser >> initEngineElement [
	| list |
	dataSource := PenInfiniteDataSource new.
	self model engineElement: PenInfiniteListElement new.
	self model engineElement constraintsDo: [:c |
		c horizontal matchParent.
		c vertical matchParent]. 
	
	list := self model items collect: [ :item | 
		item engineElement 
			constraintsDo: [ :c | c horizontal matchParent ];
			yourself ].
	dataSource elements: list.
	self model engineElement dataSource: dataSource.
	
	self model allowToSelect ifFalse: [ ^ self ].

	pushedItem := false.
	self model items do: [ :item |
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
