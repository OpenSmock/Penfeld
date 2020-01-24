Class {
	#name : #PenBlocEventStrategy,
	#superclass : #PenEventStrategy,
	#category : #'Penfeld-Bloc-Utils'
}

{ #category : #binding }
PenBlocEventStrategy class >> bindAction: anEventBinding [
	anEventBinding source engineElement 
		when: BlClickEvent 
		do: [ :e | anEventBinding executeCallback. e consumed: true. ].
	^ true
]

{ #category : #installing }
PenBlocEventStrategy class >> bindClick: anEventBinding [
	anEventBinding source engineElement 
		when: BlClickEvent 
		do: [ :e | anEventBinding executeCallback: (PenMouseEvent fromBloc: e) ].
	^ true
]

{ #category : #installing }
PenBlocEventStrategy class >> bindMouseDown: anEventBinding [
	anEventBinding source engineElement 
		when: BlMouseDownEvent 
		do: [ :e | anEventBinding executeCallback: (PenMouseEvent fromBloc: e) ].
	^ true
]
