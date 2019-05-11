Class {
	#name : #PenList,
	#superclass : #PenInteractionElement,
	#instVars : [
		'items',
		'selectedIndexList',
		'allowToSelect',
		'multiSelection',
		'sortingBlock',
		'allowToDeselect',
		'verticalScrollBar',
		'horizontalScrollBar',
		'showVerticalScrollBar',
		'showHorizontalScrollBar'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #accessing }
PenList class >> styleName [
	^ #list
]

{ #category : #items }
PenList >> addAllItems: aList [
	aList do: [ :each | self addItem: each ]
]

{ #category : #items }
PenList >> addItem: anItem [
	| eventBinding |
	items add: anItem.
	anItem parent: self.
	anItem onActionDo: [ self select: anItem ].
]

{ #category : #accessing }
PenList >> allowToDeselect [
	^ allowToDeselect
]

{ #category : #accessing }
PenList >> allowToDeselect: anObject [
	allowToDeselect := anObject
]

{ #category : #accessing }
PenList >> allowToSelect [
	^ allowToSelect
]

{ #category : #accessing }
PenList >> allowToSelect: anObject [
	allowToSelect := anObject
]

{ #category : #building }
PenList >> build [
	self stylesheet ifNil: [ self chooseStylesheet ].
	self flag: 'Experimental: table with nthChild support'.
	(self isKindOf: PenTable) 
		ifTrue: [ self items withIndexDo: [ :item :index | item build: index ] ]
		ifFalse: [ self items do: [ :item | item build ]] .
	super build
]

{ #category : #selecting }
PenList >> clearSelectedList [
	selectedIndexList do: [ :i |
		(self items at: i) deactivatePseudoClass: #checked ].
	selectedIndexList removeAll.
]

{ #category : #initialization }
PenList >> defaultSortingBlock [
	^ [:a :b | true]
]

{ #category : #api }
PenList >> hideHorizontalScrollBar [
	showHorizontalScrollBar := false
]

{ #category : #api }
PenList >> hideVerticalScrollBar [
	showVerticalScrollBar := false
]

{ #category : #initialization }
PenList >> initialize [
	super initialize.
	items := OrderedCollection new.
	selectedIndexList := OrderedCollection new.
	allowToSelect := false.
	allowToDeselect := true.
	multiSelection := false.
	sortingBlock := self defaultSortingBlock.
	showHorizontalScrollBar := true.
	showVerticalScrollBar := true.
]

{ #category : #testing }
PenList >> isHorizontalScrollBarVisible [
	^ showHorizontalScrollBar 
]

{ #category : #testing }
PenList >> isVerticalScrollBarVisible [
	^ showVerticalScrollBar
]

{ #category : #accessing }
PenList >> items [
	^ items sorted: self sortingBlock
]

{ #category : #accessing }
PenList >> multiSelection [
	^ multiSelection
]

{ #category : #accessing }
PenList >> multiSelection: anObject [
	multiSelection := anObject
]

{ #category : #'api - events' }
PenList >> onSelectionChangedDo: aBlock [
	self onEvent: PenEventSymbol selectionChanged do: aBlock
]

{ #category : #events }
PenList >> receiveClickEvent: anEvent [
	self allowToSelect ifFalse: [ ^ self ].
	self select: anEvent target.
]

{ #category : #dressing }
PenList >> refresh [
	| sortedList |
	super refresh.
	sortedList := self items.
	self selectedIndexList do: [ :i |
		(sortedList at: i) activatePseudoClass: #checked ]
]

{ #category : #selecting }
PenList >> select: anItem [
	| index |
	self flag: 'To optimize: Send selection changed when selection has changed.'.
	
	self allowToSelect ifFalse: [ ^self ].
	
	index := self items indexOf: anItem.
	self selectedIndexList isEmpty
		ifTrue: [ 
			self selectedIndexList add: index.
			anItem activatePseudoClass: #checked. ]
		ifFalse: [ 
			(self selectedIndexList includes: index)
				ifTrue: [ 
					self allowToDeselect
						ifTrue: [ self selectedIndexList remove: index. anItem deactivatePseudoClass: #checked ]
						ifFalse: [ anItem activatePseudoClass: #checked ]]
				ifFalse: [ 
					self multiSelection ifFalse: [ self clearSelectedList ].
					self selectedIndexList add: index.
					anItem activatePseudoClass: #checked ] ].

	self selectionChangedEvent 
	
]

{ #category : #accessing }
PenList >> selectedIndexList [
	^ selectedIndexList
]

{ #category : #accessing }
PenList >> selectedIndexList: anObject [
	selectedIndexList := anObject
]

{ #category : #accessing }
PenList >> selection [
	^ self selectedIndexList 
]

{ #category : #events }
PenList >> selectionChangedEvent [
	self eventBindings do: [ :eventBinding |
		(eventBinding symbol = PenEventSymbol selectionChanged)
			ifTrue: [ eventBinding callback value ]].
]

{ #category : #api }
PenList >> showHorizontalScrollBar [
	showHorizontalScrollBar := true
]

{ #category : #api }
PenList >> showVerticalScrollBar [
	showVerticalScrollBar := true
]

{ #category : #accessing }
PenList >> sortingBlock [
	^ sortingBlock
]

{ #category : #accessing }
PenList >> sortingBlock: anObject [
	sortingBlock := anObject
]

{ #category : #accessing }
PenList >> stylesheet: aStyle [
	items do: [ :item | item stylesheet: aStyle ].
	super stylesheet: aStyle.
]
