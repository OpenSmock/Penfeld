Class {
	#name : #PenBlocListDresser,
	#superclass : #PenBlocDresser,
	#instVars : [
		'dataSource',
		'pushedItem'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #styling }
PenBlocListDresser >> backgroundColor: aValue [
	self model interactor background: aValue
]

{ #category : #rendering }
PenBlocListDresser >> doAfterApplyStyle [ 
	| var |

	"Position"
	var := self model position.
	var ifNotNil: [ self model interactor relocate: var ].

	"Width"
	var := self model width.
	var ifNotNil: [ self model interactor width: var pref ].
	
	"Height"
	var := self model height.
	var ifNotNil: [ self model interactor height: var pref ]
]

{ #category : #dressing }
PenBlocListDresser >> initInteractor [
	| list |
	dataSource := PenInfiniteDataSource new.
	self model interactor: PenInfiniteListElement new.
	self model interactor constraintsDo: [:c |
		c horizontal matchParent.
		c vertical matchParent]. 
	
	list := self model items collect: [ :item | 
		item interactor 
			constraintsDo: [ :c | c horizontal matchParent ];
			yourself ].
	dataSource elements: list.
	self model interactor dataSource: dataSource.
	
	self model allowToSelect ifFalse: [ ^ self ].

	pushedItem := false.
	self model items do: [ :item |
		item interactor when: BlMouseDownEvent do: [ :e | self whenMouseDownEventOn: item ].
		item interactor when: BlMouseUpEvent do: [ :e | self whenMouseUpEventOn: item ].
		item interactor when: BlMouseLeaveEvent do: [ :e | self whenMouseLeaveEventOn: item ].].
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
