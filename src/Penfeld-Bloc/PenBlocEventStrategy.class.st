Class {
	#name : #PenBlocEventStrategy,
	#superclass : #PenEventStrategy,
	#category : #'Penfeld-Bloc-Utils'
}

{ #category : #installing }
PenBlocEventStrategy >> tryToBind: anEventBinding whenActionOn: aComponent [
	aComponent engineElement 
		when: BlClickEvent 
		do: [ :e | anEventBinding source actionEvent ].
	^ true
]

{ #category : #installing }
PenBlocEventStrategy >> tryToBind: anEventBinding whenClickOn: aComponent [
	aComponent engineElement 
		when: BlClickEvent 
		do: [ :e | anEventBinding source clickEvent: (PenEvent fromBloc: e) ].
	^ true
]

{ #category : #installing }
PenBlocEventStrategy >> tryToBind: anEventBinding whenMouseDownOn: aComponent [
	aComponent engineElement 
		when: BlMouseDownEvent 
		do: [ :e | anEventBinding source mouseDownEvent: (PenEvent fromBloc: e) ].
	^ true
]

{ #category : #installing }
PenBlocEventStrategy >> tryToBindActionOn: aComponent [
	aComponent engineElement 
		when: BlClickEvent 
		do: [ :e | aComponent actionEvent ].
	^ true
]

{ #category : #installing }
PenBlocEventStrategy >> tryToBindClickOn: aComponent [
	aComponent engineElement 
		when: BlClickEvent 
		do: [ :e | aComponent clickEvent: (PenMouseEvent fromBloc: e) ].
	^ true
]

{ #category : #installing }
PenBlocEventStrategy >> tryToBindMouseDownOn: aComponent [
	aComponent engineElement 
		when: BlMouseDownEvent 
		do: [ :e | aComponent mouseDownEvent: (PenMouseEvent fromBloc: e) ].
	^ true
]
