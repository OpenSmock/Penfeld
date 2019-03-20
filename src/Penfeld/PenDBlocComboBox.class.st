Class {
	#name : #PenDBlocComboBox,
	#superclass : #PenBlocDresser,
	#instVars : [
		'dataSource',
		'list',
		'listDisplayed',
		'pushedItem',
		'buttonPushed'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #properties }
PenDBlocComboBox class >> styleSelector [
	^ #comboBox
]

{ #category : #dressing }
PenDBlocComboBox >> applyActiveStyleButton [
	| selectors styles |
	selectors := OrderedCollection new.
	selectors add: #body.
	selectors add: #button.
	styles := self model stylesheet stylesFor: selectors pseudoClass: #active.
	styles do: [ :style | self applyButtonStyle: style ]
]

{ #category : #dressing }
PenDBlocComboBox >> applyButtonStyle: aStyle [
	| button background border |
	button := (self model interactor childNamed: #top)
		childNamed: #button.
	background := self getBackground: aStyle.
	background ifNotNil: [ button background: background ].
	border := self getBorder: aStyle.
	border ifNotNil: [ button border: border ].
	
]

{ #category : #dressing }
PenDBlocComboBox >> applyStyle: aStyle [
	self applyStyleTop: aStyle.
	self applyStyleList: aStyle.
	
]

{ #category : #dressing }
PenDBlocComboBox >> applyStyleList: aStyle [
	| background border |
	background := self getBackground: aStyle.
	background ifNotNil: [ list background: background ].
	border := self getBorder: aStyle.
	border ifNotNil: [ list border: border ].
]

{ #category : #dressing }
PenDBlocComboBox >> applyStyleSheet [
	| styles selectors |
	super applyStyleSheet.	
	selectors := OrderedCollection new.
	selectors add: #body.
	selectors add: #button.
	styles := self model stylesheet stylesFor: selectors.
	styles do: [ :style | self applyButtonStyle: style ]
]

{ #category : #dressing }
PenDBlocComboBox >> applyStyleSheetWithPseudoClass: aPseudoClassSymbol [
	| styles selectors |
	super applyStyleSheetWithPseudoClass: aPseudoClassSymbol.	
	selectors := OrderedCollection new.
	selectors add: #body.
	selectors add: #button.
	styles := self model stylesheet stylesFor: selectors pseudoClass: aPseudoClassSymbol.
	styles do: [ :style | self applyButtonStyle: style ]
]

{ #category : #dressing }
PenDBlocComboBox >> applyStyleTop: aStyle [
	| top selectedItem button background border triangle string ropedText |
	top := self model interactor childNamed: #top.
	selectedItem := top childNamed: #selectedItem.
	button := top childNamed: #button.
	triangle := button childNamed: #triangle.
	
	"ComboBox drawing"
	"Waiting for CSS improvment to have the same colors than a button of the stylesheet"
	background := self getBackground: aStyle.
	background ifNotNil: [ selectedItem background: background ].
	border := self getBorder: aStyle.
	border ifNotNil: [ 
		selectedItem border: border.
		triangle background: border paint ].
	triangle border: BlBorder empty.
	
	string := self model selectedItemString.
	string ifNil: [ string := '-' ].
	ropedText := self getRopedText: aStyle string: string.
	ropedText ifNotNil: [ (selectedItem childNamed: #text) text: ropedText ].
	
]

{ #category : #events }
PenDBlocComboBox >> buttonReceiveMouseDownEvent [
	self model dresser applyActiveStyleButton.
	buttonPushed := true.
]

{ #category : #events }
PenDBlocComboBox >> buttonReceiveMouseLeaveEvent [
	self model dresser resetButtonStyles.
	buttonPushed := false.
]

{ #category : #events }
PenDBlocComboBox >> buttonReceiveMouseUpEvent [
	buttonPushed ifFalse: [^ self].
	self model dresser toggleList.
	self model resetStyles.
	buttonPushed := false.
]

{ #category : #protocol }
PenDBlocComboBox >> hideList [
	self model interactor space root removeChildNamed: #comboBoxList.
	listDisplayed := false.
]

{ #category : #initialization }
PenDBlocComboBox >> initInteractor [
	| button |
	listDisplayed := false.
	
	self model interactor: BlElement new.
	self model interactor layout: BlLinearLayout vertical.
	self model interactor constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	self initTop.
	self initList.
	
	button := self model interactor childNamed: #button.
	button when: BlMouseDownEvent do: [ :e | self buttonReceiveMouseDownEvent ].
	button when: BlMouseUpEvent do: [ :e | self buttonReceiveMouseUpEvent ].
	button when: BlMouseLeaveEvent do: [ :e | self buttonReceiveMouseLeaveEvent ].
	
	pushedItem := false.
	self model items do: [ :item |
		item interactor when: BlMouseDownEvent do: [ :e | self whenMouseDownEventOn: item ].
		item interactor when: BlMouseUpEvent do: [ :e | self whenMouseUpEventOn: item ].
		item interactor when: BlMouseLeaveEvent do: [ :e | self whenMouseLeaveEventOn: item ]].
]

{ #category : #initialization }
PenDBlocComboBox >> initList [
	| listElements |
	dataSource := PFInfiniteDataSource new.
	list := PFInfiniteListElement new.
	list constraintsDo: [:c |
		c horizontal exact: 170.
		c vertical exact: 120]. 
	
	listElements := self model items collect: [ :item | 
		item interactor 
			constraintsDo: [ :c | c horizontal matchParent ];
			yourself ].
	dataSource elements: listElements.
	list dataSource: dataSource.
]

{ #category : #initialization }
PenDBlocComboBox >> initTop [
	| group selectedItemGroup selectedItemText button triangle |
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
	
	self model interactor addChild: group as: #top.
]

{ #category : #dressing }
PenDBlocComboBox >> resetButtonStyles [
	| styles selectors |
	selectors := OrderedCollection new.
	selectors add: #body.
	selectors add: #button.
	styles := self model stylesheet stylesFor: selectors.
	styles do: [ :style | self applyButtonStyle: style ]
]

{ #category : #protocol }
PenDBlocComboBox >> showList [
	listDisplayed := true.
	list relocate: self model interactor positionInSpace + (0 @ 20). 
	self model interactor space root childNamed: #comboBoxList
		ifFound: [ :e | self halt: 'TODO: close the first comboBox before open a second.' ]
		ifNone: [ self model interactor space root addChild: list as: #comboBoxList ]
]

{ #category : #'as yet unclassified' }
PenDBlocComboBox >> toggleList [
	listDisplayed
		ifTrue: [ self hideList ]
		ifFalse: [ self showList ]
]

{ #category : #events }
PenDBlocComboBox >> whenMouseDownEventOn: anItem [ 
	anItem resetStyles.
	pushedItem := anItem.
]

{ #category : #events }
PenDBlocComboBox >> whenMouseLeaveEventOn: anItem [
	pushedItem = anItem
		ifTrue: 
			[ anItem resetStyles.
			pushedItem := nil].
]

{ #category : #events }
PenDBlocComboBox >> whenMouseUpEventOn: anItem [
	(pushedItem notNil and: [anItem = pushedItem]) ifTrue: [
		self model resetStyles.
		self model dresser hideList.
		pushedItem := nil].
]
