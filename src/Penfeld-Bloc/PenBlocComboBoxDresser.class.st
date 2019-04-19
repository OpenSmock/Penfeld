Class {
	#name : #PenBlocComboBoxDresser,
	#superclass : #PenBlocDresser,
	#traits : 'TPenBlocBorderStyle',
	#classTraits : 'TPenBlocBorderStyle classTrait',
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
		list background: aValue.
	]
	ifFalse: [ 
		self component engineElement background: aValue.	
		(button childNamed: #triangle) background: aValue
	]
]

{ #category : #events }
PenBlocComboBoxDresser >> buttonReceiveMouseDownEvent [
	self component activatePseudoClass: #active.
	buttonPushed := true.
]

{ #category : #events }
PenBlocComboBoxDresser >> buttonReceiveMouseLeaveEvent [
	self component clearAllPseudoClass.
	buttonPushed := false.
]

{ #category : #events }
PenBlocComboBoxDresser >> buttonReceiveMouseUpEvent [
	buttonPushed ifFalse: [^ self].
	self toggleList.
	self component refresh.
	buttonPushed := false.
]

{ #category : #dressing }
PenBlocComboBoxDresser >> doAfterApplyStyle [
	
	"Apply roped text"
	self component engineElement childNamed: #text
		ifFound: [ :anElement | anElement text: ropedText ]
		ifNone: [].
]

{ #category : #dressing }
PenBlocComboBoxDresser >> doBeforeApplyStyle [
	ropedText := self component selectedItemString asRopedText
]

{ #category : #protocol }
PenBlocComboBoxDresser >> hideList [
	self component engineElement space root removeChildNamed: #comboBoxList.
	listDisplayed := false.
]

{ #category : #dressing }
PenBlocComboBoxDresser >> initEngineElement [
	listDisplayed := false.
	
	self component engineElement: BlElement new.
	self component engineElement layout: BlLinearLayout vertical.
	self component engineElement constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	self initTop.
	self initList.
	
	button := self component engineElement childNamed: #button.
	button when: BlMouseDownEvent do: [ :e | self buttonReceiveMouseDownEvent ].
	button when: BlMouseUpEvent do: [ :e | self buttonReceiveMouseUpEvent ].
	button when: BlMouseLeaveEvent do: [ :e | self buttonReceiveMouseLeaveEvent ].
	
	pushedItem := false.
	self component items do: [ :item |
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
	
	listElements := self component items collect: [ :item | 
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
	
	self component engineElement addChild: group as: #top.
]

{ #category : #protocol }
PenBlocComboBoxDresser >> showList [
	listDisplayed := true.
	list relocate: self component engineElement positionInSpace + (0 @ 20). 
	self component engineElement space root childNamed: #comboBoxList
		ifFound: [ :e | self halt: 'TODO: close the first comboBox before open a second.' ]
		ifNone: [ self component engineElement space root addChild: list as: #comboBoxList ]
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
		self component refresh.
		self hideList.
		pushedItem := nil].
]
