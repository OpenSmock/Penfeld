Class {
	#name : #PenBlocComboBoxDresser,
	#superclass : #PenBlocDresser,
	#instVars : [
		'dataSource',
		'list',
		'listDisplayed',
		'pushedItem',
		'buttonPushed',
		'button',
		'ropedText'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #styling }
PenBlocComboBoxDresser >> backgroundColor: aValue [
	(styleSelector styleClasses includes: #cbbutton) 
	ifTrue: [ 
		button background: aValue.
	]
	ifFalse: [ 
		self model engineElement background: aValue.	
		(button childNamed: #triangle) background: aValue
	]
]

{ #category : #styling }
PenBlocComboBoxDresser >> border: aValue [
	| borderBuilder |	
	borderBuilder := BlBorderBuilder new.	
		
	aValue do: 
	[ :property | 
		property isNumber 
		ifTrue: [ borderBuilder width: property ] 
		ifFalse: 
		[
			property isSymbol
			ifTrue: [ 
				(borderBuilder respondsTo: property) 
				ifTrue: [ borderBuilder perform: property ] 
			]
			ifFalse: [ 
				(property isKindOf: Color)
				ifTrue: [ borderBuilder paint: property ]
				ifFalse: [ self notYetImplemented ]
			]
		]
	].
	self model engineElement border: borderBuilder build.
]

{ #category : #events }
PenBlocComboBoxDresser >> buttonReceiveMouseDownEvent [
	self model activatePseudoClass: #active.
	buttonPushed := true.
]

{ #category : #events }
PenBlocComboBoxDresser >> buttonReceiveMouseLeaveEvent [
	self model clearAllPseudoClass.
	buttonPushed := false.
]

{ #category : #events }
PenBlocComboBoxDresser >> buttonReceiveMouseUpEvent [
	buttonPushed ifFalse: [^ self].
	self toggleList.
	self model refresh.
	buttonPushed := false.
]

{ #category : #dressing }
PenBlocComboBoxDresser >> doAfterApplyStyle [
	
	"Apply roped text"
	self model engineElement childNamed: #text
		ifFound: [ :anElement | anElement text: ropedText ]
		ifNone: [].
]

{ #category : #dressing }
PenBlocComboBoxDresser >> doBeforeApplyStyle [
	ropedText := self model selectedItemString asRopedText
]

{ #category : #protocol }
PenBlocComboBoxDresser >> hideList [
	self model engineElement space root removeChildNamed: #comboBoxList.
	listDisplayed := false.
]

{ #category : #dressing }
PenBlocComboBoxDresser >> initEngineElement [
	listDisplayed := false.
	
	self model engineElement: BlElement new.
	self model engineElement layout: BlLinearLayout vertical.
	self model engineElement constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	self initTop.
	self initList.
	
	button := self model engineElement childNamed: #button.
	button when: BlMouseDownEvent do: [ :e | self buttonReceiveMouseDownEvent ].
	button when: BlMouseUpEvent do: [ :e | self buttonReceiveMouseUpEvent ].
	button when: BlMouseLeaveEvent do: [ :e | self buttonReceiveMouseLeaveEvent ].
	
	pushedItem := false.
	self model items do: [ :item |
		item engineElement when: BlMouseDownEvent do: [ :e | self whenMouseDownEventOn: item ].
		item engineElement when: BlMouseUpEvent do: [ :e | self whenMouseUpEventOn: item ].
		item engineElement when: BlMouseLeaveEvent do: [ :e | self whenMouseLeaveEventOn: item ]].
]

{ #category : #dressing }
PenBlocComboBoxDresser >> initList [
	| listElements |
	dataSource := PenInfiniteDataSource new.
	list := PenInfiniteListElement new.
	list constraintsDo: [:c |
		c horizontal exact: 170.
		c vertical exact: 120]. 
	
	listElements := self model items collect: [ :item | 
		item engineElement 
			constraintsDo: [ :c | c horizontal matchParent ];
			yourself ].
	dataSource elements: listElements.
	list dataSource: dataSource.
]

{ #category : #dressing }
PenBlocComboBoxDresser >> initTop [
	| group selectedItemGroup selectedItemText triangle |
	group := BlElement new.
	group layout: BlLinearLayout horizontal.
	group constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	
	selectedItemGroup := BlElement new.
	selectedItemGroup layout: BlFrameLayout new.
	selectedItemGroup constraintsDo: [ :c |
		c horizontal exact: 150.
		c vertical exact: 20 ].
	
	selectedItemText := BlTextElement new.
	selectedItemGroup constraintsDo: [ :c |
		c frame vertical alignCenter].
	
	button := BlElement new.
	button layout: BlFrameLayout new.
	button constraintsDo: [ :c |
		c horizontal exact: 20.
		c vertical exact: 20 ].
	triangle := (BlPolygon vertices: { 0@0. 12@0. 6@10 }) asElement.
	triangle constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	button addChild: triangle as: #triangle.
	selectedItemGroup addChild: selectedItemText as: #text.
	group addChild: selectedItemGroup as: #selectedItem.
	group addChild: button as: #button.
	
	self model engineElement addChild: group as: #top.
]

{ #category : #protocol }
PenBlocComboBoxDresser >> showList [
	listDisplayed := true.
	list relocate: self model engineElement positionInSpace + (0 @ 20). 
	self model engineElement space root childNamed: #comboBoxList
		ifFound: [ :e | self halt: 'TODO: close the first comboBox before open a second.' ]
		ifNone: [ self model engineElement space root addChild: list as: #comboBoxList ]
]

{ #category : #protocol }
PenBlocComboBoxDresser >> toggleList [
	listDisplayed
		ifTrue: [ self hideList ]
		ifFalse: [ self showList ]
]

{ #category : #events }
PenBlocComboBoxDresser >> whenMouseDownEventOn: anItem [ 
	anItem refresh.
	pushedItem := anItem.
]

{ #category : #events }
PenBlocComboBoxDresser >> whenMouseLeaveEventOn: anItem [
	pushedItem = anItem
		ifTrue: 
			[ anItem refresh.
			pushedItem := nil].
]

{ #category : #events }
PenBlocComboBoxDresser >> whenMouseUpEventOn: anItem [
	(pushedItem notNil and: [anItem = pushedItem]) ifTrue: [
		self model refresh.
		self hideList.
		pushedItem := nil].
]
