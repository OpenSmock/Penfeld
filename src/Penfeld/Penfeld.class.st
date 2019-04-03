Class {
	#name : #Penfeld,
	#superclass : #Object,
	#classVars : [
		'DebugModeEnabled'
	],
	#category : #'Penfeld-Utils'
}

{ #category : #debugging }
Penfeld class >> debugModeEnabled [ 
	^ DebugModeEnabled ifNil: [ false ]
]

{ #category : #debugging }
Penfeld class >> debugModeEnabled: aBoolean [
	DebugModeEnabled := aBoolean
]

{ #category : #settings }
Penfeld class >> debugModeOn: aBuilder [
	<worldMenu>
	Penfeld debugModeEnabled 
		ifFalse: [ 
			(aBuilder item: #penDebugOn)
			parent: #Penfeld;
			order: 1.0;
			label: 'Enable debug mode';
			action: [ Penfeld enableDebugMode. MenubarMorph reset ]
		]
		ifTrue: [ 
			(aBuilder item: #penDebugOff)
			parent: #Penfeld;
			order: 1.0;
			label: 'Disable debug mode';
			action: [ Penfeld disableDebugMode. MenubarMorph reset ]
		]
]

{ #category : #debugging }
Penfeld class >> disableDebugMode [
	self debugModeEnabled: false
]

{ #category : #debugging }
Penfeld class >> enableDebugMode [
	self debugModeEnabled: true
]

{ #category : #settings }
Penfeld class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Penfeld)
		order: 6.1
]
