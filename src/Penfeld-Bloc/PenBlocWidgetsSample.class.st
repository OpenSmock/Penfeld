Class {
	#name : #PenBlocWidgetsSample,
	#superclass : #PenView,
	#category : #'Penfeld-Bloc-Examples'
}

{ #category : #'instance creation' }
PenBlocWidgetsSample class >> open [
	<script: 'self open'>
	^ self new open
]

{ #category : #accessing }
PenBlocWidgetsSample >> allSubclasses: aClass [
	| list |
	list := OrderedCollection new.
	aClass
		withAllSubclassesDo: [ :class | 
			| row |
			row := PenTableItem new.
			row key: class name asSymbol.
			row dresser: PenBlocTableItemDresser new.
			row atSection: #name put: (PenLabel text: class name).
			row
				atSection: #numberOfSubclasses
				put: (PenLabel text: class subclasses size printString).
			row
				atSection: #numberOfVariables
				put: (PenLabel text: class instVarNames size printString).
			list add: row ].
	^ list
]

{ #category : #accessing }
PenBlocWidgetsSample >> button [
	^ PenButton new text: 'Button'
]

{ #category : #accessing }
PenBlocWidgetsSample >> checkBoxs [
	^ PenContainer new
		layout: PenLinearLayout vertical;
		addAllElements: { 
			PenCheckBox new text: 'Value A'.
			PenCheckBox new text: 'Value B'.
			PenCheckBox new text: 'Value C'.
		 }
]

{ #category : #accessing }
PenBlocWidgetsSample >> comboBox [
	^ PenComboBox new 
		addAllItems: ((1 to: 5) 
			collect: [ :i | PenLabel text: 'Choice ', i printString ])
]

{ #category : #accessing }
PenBlocWidgetsSample >> disableButton [
	^ PenButton new
		text: 'Disabled';
		disable
]

{ #category : #accessing }
PenBlocWidgetsSample >> header [
	^ PenTableItem new
		dresser: PenBlocTableItemHeaderDresser new;
		atSection: #name put: (PenLabel new text: 'Nom');
		atSection: #numberOfSubclasses put: (PenLabel new text: 'Sub.');
		atSection: #numberOfVariables put: (PenLabel new text: 'Inst.');
		yourself
	
]

{ #category : #opening }
PenBlocWidgetsSample >> initContent [
	| container |
	
	container := PenContainer new
		layout: PenLinearLayout vertical;
		key: #mainContainer;
		size: 800@600.
		
	self displayComponent: container.
	
	container addAllElements: { 
		self titleLabel: 'Buttons'.
		PenContainer new
			layout: PenLinearLayout horizontal;
			addAllElements: { 
				self button.
				self toggleButton.
				self disableButton.
				"self comboBox."
			}.
		PenContainer new 
			layout: PenLinearLayout horizontal;
			addAllElements: { 
				PenContainer new
					layout: PenLinearLayout vertical;
					addAllElements: { 
						self titleLabel: 'Check Boxs & Radios'.
						PenContainer new
							layout: PenLinearLayout horizontal;
							addAllElements: { self checkBoxs. self radios. }.
					}.
				PenContainer new
					layout: PenLinearLayout vertical;
					addAllElements: { 
						self titleLabel: 'Sliders'.
						self slider.
						self slider2.
					}.
			}.
		PenContainer new
			layout: PenLinearLayout horizontal;
			addAllElements: { 
				PenShape new size: 10@0.
				PenContainer new
					layout: PenLinearLayout vertical;
					addAllElements: { 
						self titleLabel: 'List'.
						self list.
					}.
				PenShape new size: 15@0.
				PenContainer new
					layout: PenLinearLayout vertical;
					addAllElements: { 
						self titleLabel: 'Table'.
						self table.
					}.
				PenShape new size: 15@0.
				PenContainer new
					layout: PenLinearLayout vertical;
					addAllElements: { 
						self titleLabel: 'Tree'.
						self tree.
					}.
			}.
	}.
]

{ #category : #opening }
PenBlocWidgetsSample >> initialize [ 
	super initialize.
	self initContent.
]

{ #category : #accessing }
PenBlocWidgetsSample >> list [
	^ PenList new 
		size: 220@280;
		addAllItems:  (PenElement withAllSubclasses 
			collect: [ :c | PenLabel new text: c name ]);
		sortingBlock: [ :a :b | a text < b text ];
		allowToSelect: true;
		multiSelection: true;
		yourself
]

{ #category : #accessing }
PenBlocWidgetsSample >> nodeForClass: aClass [
	| node |
	node := PenTreeNode new.
	node key: aClass name asSymbol.
	node content: (PenLabel new text: aClass name).
	aClass subclasses do: [ :subclass | 
		node addNode: (self nodeForClass: subclass)].
	^ node
]

{ #category : #opening }
PenBlocWidgetsSample >> open [
	self openInWorld 
]

{ #category : #accessing }
PenBlocWidgetsSample >> progressBar [
	^ PenProgressBar new
		interval: (0 to: 100 by: 1);
		size: 300@20
]

{ #category : #accessing }
PenBlocWidgetsSample >> radios [
	| radios |
	radios := { 
		PenRadioButton new text: 'Choice 1'. 
		PenRadioButton new text: 'Choice 2'. 
		PenRadioButton new text: 'Choice 3'. 
	}.
	PenRadioGroup new addAll: radios.
	^ PenContainer new 
		layout: PenLinearLayout vertical;
		addAllElements: radios
]

{ #category : #accessing }
PenBlocWidgetsSample >> slider [
	^ PenSlider new
		interval: (0 to: 350 by: 10);
		middle
]

{ #category : #accessing }
PenBlocWidgetsSample >> slider2 [
	^ PenSlider new
		interval: (40 to: 180 by: 20);
		middle
]

{ #category : #accessing }
PenBlocWidgetsSample >> table [
	| component |
	component := PenTable new.
	component size: 220@280.
	component sections: { 
		PenSection new selector: #name.
		PenSection new selector: #numberOfSubclasses; size: 40.
		PenSection new selector: #numberOfVariables; size: 40 }.
	component header: self header.
	component addAllItems: (self allSubclasses: PenComponent).
	component sortingBlock: [ :a :b | a key < b key ].
	component dragSections: true.
	component allowToSelect: true.
	^ component
]

{ #category : #accessing }
PenBlocWidgetsSample >> titleLabel: aString [
	^ PenLabel new
		text: aString;
		addStyleClass: #title.
]

{ #category : #accessing }
PenBlocWidgetsSample >> toggleButton [
	^ PenToggleButton new text: 'Toggle'
]

{ #category : #accessing }
PenBlocWidgetsSample >> tree [
	^ PenTree new
		size: 220@280;
		root: (self nodeForClass: PenComponent);
		dresser: PenBlocTreeDresser new;
		sortingBlock: [ :a :b | a key < b key ].
]
