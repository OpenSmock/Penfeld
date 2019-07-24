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
	var := self component position.
	var ifNotNil: [ self component engineElement relocate: var ].

	"Width"
	var := self component width.
	var ifNotNil: [ self component engineElement width: var pref ].
	
	"Height"
	var := self component height.
	var ifNotNil: [ self component engineElement height: var pref ]
]

{ #category : #dressing }
PenBlocListDresser >> initEngineElement [
	| list |
	dataSource := PenInfiniteDataSource new.
	self component engineElement: PenInfiniteListElement new.
	self component engineElement constraintsDo: [:c |
		c horizontal matchParent.
		c vertical matchParent]. 
	
	list := self component items collect: [ :item | 
		item engineElement 
			constraintsDo: [ :c | c horizontal matchParent ];
			yourself ].
	dataSource elements: list.
	self component engineElement dataSource: dataSource.
	
	self component allowToSelect ifFalse: [ ^ self ].

	pushedItem := false.
	self component items do: [ :item |
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
