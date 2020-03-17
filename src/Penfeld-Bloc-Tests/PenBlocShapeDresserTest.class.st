"
A PenBlocShapeDresserTest is a test class for testing the behavior of PenBlocShapeDresser
"
Class {
	#name : #PenBlocShapeDresserTest,
	#superclass : #TestCase,
	#category : #'Penfeld-Bloc-Tests-Dressers'
}

{ #category : #'tests - build geometry' }
PenBlocShapeDresserTest >> testBuildCircle [
	<PenExample>
	| shape |
	shape := PenShape new 
		shape: (GCircle center: 100 , 100 radius: 30); 
		dresser: PenBlocShapeDresser new;
		build.
	^ shape engineElement
]

{ #category : #'tests - build geometry' }
PenBlocShapeDresserTest >> testBuildEllipse [
	<PenExample>
	| shape |
	shape := PenShape new
		shape: (GEllipse center: 40 , 10 vertex: 60 , 10 coVertex: 40 , 20);
		dresser: PenBlocShapeDresser new;
		build.
	^ shape engineElement
]

{ #category : #'tests - build geometry' }
PenBlocShapeDresserTest >> testBuildPolygon [
	<PenExample>
	| shape |
	shape := PenShape new 
		shape: (GPolygon vertices: {(10 , 10) . (30 , 10) . (50 , 50) . (30 , 70) . (10 , 50)}); 
		dresser: PenBlocShapeDresser new;
		build.
	^ shape engineElement
]

{ #category : #'tests - build geometry' }
PenBlocShapeDresserTest >> testBuildRectangle [
	<PenExample>
	| shape |
	shape := PenShape new 
		shape: (GRectangle origin: 0 , 0 corner: 100 , 50);
		dresser: PenBlocShapeDresser new;
		build.
	^ shape engineElement
]

{ #category : #'tests - build geometry' }
PenBlocShapeDresserTest >> testBuildTriangle [
	<PenExample>
	| shape |
	shape := PenShape new 
		shape: (GTriangle with: 10 , 10 with: 50 , 0 with: 50 , 50);
		dresser: PenBlocShapeDresser new;
		build.
	
	^ shape engineElement
]
