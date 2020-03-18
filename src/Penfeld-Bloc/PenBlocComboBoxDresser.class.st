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

{ #category : #events }
PenBlocComboBoxDresser >> buttonReceiveMouseDownEventOn: aComponent [
	aComponent activatePseudoClass: #active.
	buttonPushed := true.
]

{ #category : #events }
PenBlocComboBoxDresser >> buttonReceiveMouseLeaveEventOn: aComponent [
	aComponent clearAllPseudoClass.
	buttonPushed := false.
]

{ #category : #events }
PenBlocComboBoxDresser >> buttonReceiveMouseUpEventOn: aComponent [
	buttonPushed ifFalse: [^ self].
	self toggleList: aComponent.
	aComponent refresh.
	buttonPushed := false.
]

{ #category : #dressing }
PenBlocComboBoxDresser >> doAfterApplyStyleOn: aComponent [
	
	"Apply roped text"
	aComponent engineElement childNamed: #text
		ifFound: [ :anElement | anElement text: ropedText ]
		ifNone: [].
]

{ #category : #dressing }
PenBlocComboBoxDresser >> doBeforeApplyStyleOn: aComponent [
	ropedText := aComponent selectedItemString asRopedText
]

{ #category : #protocol }
PenBlocComboBoxDresser >> hideList: aComponent [
	aComponent engineElement space root removeChildNamed: #comboBoxList.
	listDisplayed := false.
]

{ #category : #dressing }
PenBlocComboBoxDresser >> initEngineElementFor: aComponent [
	listDisplayed := false.
	
	aComponent engineElement: BlElement new.
	aComponent engineElement layout: BlLinearLayout vertical.
	aComponent engineElement constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	self initTop: aComponent.
	self initList: aComponent.
	
	button := aComponent engineElement childNamed: #button.
	button when: BlMouseDownEvent do: [ :e | self buttonReceiveMouseDownEventOn: aComponent ].
	button when: BlMouseUpEvent do: [ :e | self buttonReceiveMouseUpEventOn: aComponent ].
	button when: BlMouseLeaveEvent do: [ :e | self buttonReceiveMouseLeaveEventOn: aComponent ].
	
	pushedItem := false.
	aComponent items do: [ :item |
		item engineElement when: BlMouseDownEvent do: [ :e | self whenMouseDownEventOn: item ].
		item engineElement when: BlMouseUpEvent do: [ :e | self whenMouseUpEventOn: item ].
		item engineElement when: BlMouseLeaveEvent do: [ :e | self whenMouseLeaveEventOn: item ]].
]

{ #category : #dressing }
PenBlocComboBoxDresser >> initList: aComponent [
	| listElements |
	dataSource := PenInfiniteDataSource new.
	list := PenInfiniteListElement new.
	list constraintsDo: [:c |
		c horizontal exact: 170.
		c vertical exact: 120]. 
	
	listElements := aComponent items collect: [ :item | 
		item engineElement 
			constraintsDo: [ :c | c horizontal matchParent ];
			yourself ].
	dataSource elements: listElements.
	list dataSource: dataSource.
]

{ #category : #dressing }
PenBlocComboBoxDresser >> initTop: aComponent [
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
	
	aComponent engineElement addChild: group as: #top.
]

{ #category : #protocol }
PenBlocComboBoxDresser >> showList: aComponent [
	listDisplayed := true.
	list relocate: aComponent engineElement positionInSpace + (0 @ 20). 
	aComponent engineElement space root childNamed: #comboBoxList
		ifFound: [ :e | self halt: 'TODO: close the first comboBox before open a second.' ]
		ifNone: [ aComponent engineElement space root addChild: list as: #comboBoxList ]
]

{ #category : #protocol }
PenBlocComboBoxDresser >> toggleList: aComponent [
	listDisplayed
		ifTrue: [ self hideList: aComponent ]
		ifFalse: [ self showList: aComponent ]
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
