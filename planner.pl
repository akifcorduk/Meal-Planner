:-include('plannerData.pl').

%removes duplicate elemets in the list
removeDups([], []).
removeDups([H|T], [H|T1]) :-
    delete(T,H,T2),
    removeDups(T2, T1).

%findsfood according to foodgroup
findfood([H|T],A)   :-
       (foodGroup(H,Y),member(A,Y));findfood(T,A).

%finds all meals according to foodgroup
allMeals(AllergyList,List)  :-
       findall(X,(findfood(AllergyList,Y),meal(X,Z,_,_,_),member(Y,Z)),L),removeDups(L,List).

%finds all allergy meals
findAllergyMeals(All,Initial,Meal)  :-
      findall(A,( member(A,Initial),allMeals(All,X),member(A,X)),Meal).

%finds all liked meals
allLikedMeals(Like,Meal)  :-
     findall(A,(meal(A,X,_,_,_),member(B,Like),member(B,X)),Meal).
findLikeMeals(Like,Initial,MealList)  :-
     findall(A,(allLikedMeals(Like,X),member(A,X),member(A,Initial)),Meal),removeDups(Meal,MealList).


findMeals(TypeList,MealList)  :-
      findall(A,(member(X,TypeList),cannotEatGroup(X,FoodGroup,Calorie), (calorieLimit(A,Calorie) ; ( allMeals(FoodGroup,L),member(A,L)) )),MealList).

calorieLimit(Meal,CalorieLimit)      :-
      CalorieLimit>0,meal(Meal,_,X,_,_), CalorieLimit<X.

 %finds not eating type meals
findNotEatingTypeMeals(TypeList,Initial,MealList)  :-
      findall(K,(findMeals(TypeList,B),member(K,B),member(K,Initial)),Meal),removeDups(Meal,MealList).



%finds meals according to time in hand
findMealsForTime(X,Initial,MealList)  :-
     findall(A,( member(A,Initial), meal(A,_,_,B,_), B=<X ),MealList).


%finds meals according to money in hand
findMealsForMoney(X,Initial,MealList)   :-
     findall(A,(member(A,Initial),meal(A,_,_,_,B),  B=<X),MealList).



%sorts liked list
orderLikedList(LikeList,Initial,MealList)  :-
     findall(A,(member(A,LikeList),member(A,Initial)),FirstList),
     findall(B,(member(B,Initial),\+member(B,LikeList)),SecondList),
     append(FirstList,SecondList,MealList).


 %all meals
allMeals(X)  :-
     findall(A,meal(A,_,_,_,_),X).


%unites all predicates and creates personallist
listPersonalList(Customer,PersonalList)   :-
     customer(Customer,Allergy,Type,Dislikes,Likes,Time,Money),
     allMeals(A),
     findAllergyMeals(Allergy,A,B),
     subtract(A,B,K),
     findNotEatingTypeMeals(Type,K,C),
     subtract(K,C,L),
     findLikeMeals(Dislikes,L,D),
     subtract(L,D,M),
     findLikeMeals(Likes,M,E),
     orderLikedList(E,M,F),
     findMealsForTime(Time,F,H),
     findMealsForMoney(Money,H,PersonalList),
     write(PersonalList).


