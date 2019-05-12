Class {
	#name : #PenBlocWidgetsSample,
	#superclass : #PenStylesheet,
	#category : #'Penfeld-Bloc-Examples'
}

{ #category : #'instance creation' }
PenBlocWidgetsSample class >> open [
	<script: 'self open'>
	^ self new open
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

{ #category : #opening }
PenBlocWidgetsSample >> open [
	| container |
	container := PenContainer new
		layout: PenLinearLayout vertical;
		key: #mainContainer;
		size: 800@600.
	container addAllElements: { 
		self titleLabel: 'Buttons'.
		PenContainer new
			layout: PenLinearLayout horizontal;
			addAllElements: { 
				self button.
				self toggleButton.
				self disableButton.
				self comboBox.
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
		self progressBar.
	}.
	container openInWorld
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
PenBlocWidgetsSample >> titleLabel: aString [
	^ PenLabel new
		text: aString;
		addStyleClass: #title.
]

{ #category : #accessing }
PenBlocWidgetsSample >> toggleButton [
	^ PenToggleButton new text: 'Toggle'
]
