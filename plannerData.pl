
%foodGroup(GroupName, FoodList).
foodGroup(vegetable, [cauliflower, spinach, potato, zucchini, onion, lettuce]).
foodGroup(meat, [chicken, beef, lamb, fish, egg]).
foodGroup(cheese, [feta, mozeralla, parmesan, gouda, edam, emmental, kasar, ezine]).
foodGroup(fruit, [lemon, banana, tomato, eggplant, pineapple, strawberry, blueberry, raspbery, grape, cucumber, orange, lemon, cranberry]).
foodGroup(grain,[wheat, flour, rice, oat, barley, bread, pasta, corn, bakingPowder]).
foodGroup(nut, [peanut, hazelnut, walnut, pistachio, pecan, cashew]).
foodGroup(oil, [oliveOil, butter]).
foodGroup(confection, [sugar, brownSugar, candy, chocolate, cocoa, honey]).
foodGroup(spice, [salt, pepper, curry, ginger, cinnamon, thyme]).
foodGroup(dairy, [milk, yogurt, cream, butter, iceCream, feta, mozeralla, parmesan, gouda, edam, emmental, kasar, ezine]).
foodGroup(drinks, [water, tea, soda, cola, fruitJuice]).

%cannotEatGroup(EatingType, CannotEatFoodGroupList, CalorieLimit). If CalorieLimit is different than 0, then the group cannot eat meals with
%Calorie > CalorieLimit,
%else if CalorieLimit is 0, there is no limit to Calorie intake. CannotEatFoodGroupList consists of the list of foodGroups that the EatingType cannot eat.
cannotEatGroup(normal,[], 0).
cannotEatGroup(vegetarian,[meat], 0).
cannotEatGroup(vegan,[meat, dairy], 0).
cannotEatGroup(diabetic, [confection], 0).
cannotEatGroup(diet, [], 220).

%meal(MealName, IngredientList, Calorie (in kcal), PrepTime (in minutes), Price (in TL)).
meal(muesli, [wheat, oat, honey, hazelnut, cranberry, grape, milk], 220, 8, 6).
meal(bananaOatmeal, [oat, milk, cinnamon, banana, walnut], 150, 10, 5).
meal(cheeseCrepe, [flour, egg, milk, oliveOil, emmental, feta, kasar, salt], 134, 18, 10).
meal(eggSandwich, [egg, flour, salt, thyme, pepper, lettuce, corn, tomato], 170, 16, 12).
meal(saladWithNuts, [peanut, walnut, pecan, cashew, tomato, cucumber, corn, lettuce], 120, 15, 18).
meal(tomatoSoup, [tomato, flour, milk, butter, kasar, salt], 150, 15, 5).
meal(friedZucchini, [zucchini, tomato, oliveOil, salt], 295, 20, 14).
meal(karniyarik, [eggplant, onion, tomato, beef, oliveOil, salt], 270, 20, 15).
meal(chickenWrap, [chicken, lettuce, corn, tomato, cucumber, yogurt, flour, salt], 180, 20, 15).
meal(fishSticks, [fish, oliveOil, flour, egg], 250, 12, 13).
meal(salmon, [fish, lemon, salt, pepper], 100, 40, 30).
meal(bananaCake, [flour, banana, salt, butter, sugar, egg], 192, 6, 7).
meal(hazelnutBrownie, [hazelnut, butter, sugar, egg, flour, salt, bakingPowder, honey], 350, 12, 8).
meal(chocolateBrownie, [chocolate, cocoa, butter, sugar, egg, flour, salt, bakingPowder, honey], 450, 12, 8).
meal(tea, [tea], 0, 5, 1).
meal(ayran, [yogurt, water, salt], 76, 0, 2).

%customer(CustomerName, AllergyList (should be a foodGroup), EatingType (vegetarian, vegan, diabetic, diet, normal), Dislikes (food list), Likes (food list), TimeInHand, MoneyInHand).
customer(amy, [], [normal], [], [], 50, 100). %list all meals
customer(jack, [nut], [normal], [], [], 40, 80). %check allergy
customer(melanie, [], [vegetarian], [], [], 40, 70). %check eating type
customer(wendy, [], [diet], [], [], 40, 60). %check eating type
customer(john, [], [vegan, diabetic], [], [], 40, 50). %check eating type
customer(bailey, [], [normal], [zucchini, peanut], [], 40, 40). %check dislikes
customer(sarah, [], [normal], [], [chocolate, banana], 40, 30). %check likes
customer(brad, [], [normal], [], [], 15, 12). %check time+money in hand
customer(alison, [], [vegan], [tea], [], 40, 10). %should return []
customer(nick, [cheese], [diet], [fish, tomato], [chicken, walnut], 15, 20). %check all



