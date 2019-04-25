Class {
	#name : #PenBlocDresserTest,
	#superclass : #TestCase,
	#category : #'Penfeld-Bloc-Tests'
}

{ #category : #tests }
PenBlocDresserTest >> testMargin1 [
	| stylesheet container button |
	stylesheet := PssParser parse: 'button { margin: 10px; }'.
	
	button := PenButton new.
	button text: 'Button'.
	
	container := PenContainer new
		size: 300@300;
		layout: PenLinearLayout new;
		stylesheet: stylesheet;
		addElement: button.
	container build.
	container engineElement forceLayout.
	
	self assert: button engineElement bounds position equals: 10@10
]

{ #category : #tests }
PenBlocDresserTest >> testMargin2 [
	| stylesheet container button |
	stylesheet := PssParser parse: 'button { margin: 10px 20px; }'.
	
	button := PenButton new.
	button text: 'Button'.
	
	container := PenContainer new
		size: 300@300;
		layout: PenLinearLayout new;
		stylesheet: stylesheet;
		addElement: button.
	container build.
	container engineElement forceLayout.
	
	self assert: button engineElement bounds position equals: 20@10
]

{ #category : #tests }
PenBlocDresserTest >> testMargin2b [
	| stylesheet container button |
	stylesheet := PssParser parse: 'button { margin: 0 20px; }'.
	
	button := PenButton new.
	button text: 'Button'.
	
	container := PenContainer new
		size: 300@300;
		layout: PenLinearLayout new;
		stylesheet: stylesheet;
		addElement: button.
	container build.
	container engineElement forceLayout.
	
	self assert: button engineElement bounds position equals: 20@0
]

{ #category : #tests }
PenBlocDresserTest >> testMargin3 [
	| stylesheet container button1 button2 |
	stylesheet := PssParser parse: 'button { margin: 10px 20px 30px; }'.
	
	button1 := PenButton new size: 50@20.
	button2 := PenButton new.
	
	container := PenContainer new
		size: 300@300;
		layout: PenLinearLayout vertical;
		stylesheet: stylesheet;
		addAllElements: { button1. button2 }.
	container build.
	container engineElement forceLayout.
	
	self assert: button1 engineElement bounds position equals: 20@10.
	self assert: button2 engineElement bounds position equals: 20@70
]

{ #category : #tests }
PenBlocDresserTest >> testMargin4 [
	| stylesheet container1 container2 button1 button2 button3 |
	stylesheet := PssParser parse: 'button { 
		margin: 10px 20px 30px 40px;
		width: 50px;
		height: 20px;
		background-color: gray;
	}'.
	
	button1 := PenButton new.
	button2 := PenButton new.
	button3 := PenButton new.
	
	container1 := PenContainer new
		layout: PenLinearLayout horizontal;
		addAllElements: { button1. button2 }.
	
	container2 := PenContainer new
		size: 300@300;
		layout: PenLinearLayout vertical;
		stylesheet: stylesheet;
		addAllElements: { container1. button3 }.
	container2 build.
	container2 engineElement forceLayout.
	
	self assert: button1 engineElement bounds position equals: 20@10.
	self assert: button2 engineElement bounds position equals: 130@10.
	self assert: button3 engineElement bounds position equals: 20@70
]
