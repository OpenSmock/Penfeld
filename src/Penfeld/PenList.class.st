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
		'horizontalScrollBar'
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
	items add: anItem.
	anItem parent: self.
	anItem onActionDo: [ self select: anItem ].
	self setUnselected: anItem.
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
	selectedIndexList do: [ :i | self setUnselected: (self items at: i) ].
	selectedIndexList removeAll.
]

{ #category : #initialization }
PenList >> defaultSortingBlock [
	^ [:a :b | true]
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
]

{ #category : #accessing }
PenList >> items [
	^ items sorted: self sortingBlock
]

{ #category : #dressing }
PenList >> loopRefresh [
	super loopRefresh.
	self items do: [ :e | e loopRefresh ]
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

{ #category : #'api - events' }
PenList >> onSelectionChangedPerform: aSymbol on: aReceiver [
	self onEvent: PenEventSymbol selectionChanged perform: aSymbol on: aReceiver
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

{ #category : #removing }
PenList >> removeAllItems [
	items do: [ :item | self removeItem: item ].
	self clearSelectedList.
]

{ #category : #removing }
PenList >> removeItem: anElement [
	self flag: #toDo.
	"If an element is selected, unselect it first"
	
	self items remove: anElement ifAbsent: [ ^ self ].
	self refresh
]

{ #category : #selecting }
PenList >> select: anItem [
	| index |
	self flag: 'Send selection changed when selection has changed.'.
	
	self allowToSelect ifFalse: [ ^self ].
	
	index := self items indexOf: anItem.
	self selectedIndexList isEmpty
		ifTrue: [ 
			self selectedIndexList add: index.
			self setSelected: anItem. ]
		ifFalse: [ 
			(self selectedIndexList includes: index)
				ifTrue: [ 
					self allowToDeselect
						ifTrue: [ 
							self selectedIndexList remove: index. 
							self setUnselected: anItem ]
						ifFalse: [ self setSelected: anItem]]
				ifFalse: [ 
					self multiSelection ifFalse: [ self clearSelectedList ].
					self selectedIndexList add: index.
					self setSelected: anItem ] ].

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
			ifTrue: [ eventBinding executeCallback ]].
]

{ #category : #accessing }
PenList >> selectionValues [
	^ self selectedIndexList collect: [ :i | self items at: i ].
]

{ #category : #private }
PenList >> setSelected: anItem [
	anItem activatePseudoClass: #checked.
	anItem deactivatePseudoClass: #unchecked.
]

{ #category : #private }
PenList >> setUnselected: anItem [
	anItem deactivatePseudoClass: #checked.
	anItem activatePseudoClass: #unchecked.
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
