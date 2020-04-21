class DataService {
  List veggies = [
    {
      'display': 'Potatoes',
      'value': 'Potatoes',
    },
    {
      'display': 'Mushrooms',
      'value': 'Mushrooms',
    },
    {
      'display': 'Tomatoes',
      'value': 'Tomatoes',
    },
    {
      'display': 'Onions',
      'value': 'Onions',
    },
    {
      'display': 'Garlic',
      'value': 'Garlic',
    },
    {
      'display': 'Beans',
      'value': 'Beans',
    },
    {
      'display': 'Corn',
      'value': 'Corn',
    },
    {
      'display': 'None',
      'value': 'None',
    },
  ];

  List bread = [
    {
      'display': 'Bagel',
      'value': 'Bagel',
    },
    {
      'display': 'Donuts',
      'value': 'Donuts',
    },
    {
      'display': 'Burger Buns',
      'value': 'Burger Buns',
    },
    {
      'display': 'White Bread',
      'value': 'White Bread',
    },
    {
      'display': 'Whole Wheat Bread',
      'value': 'Whole Wheat Bread',
    },
    {
      'display': 'Tacos',
      'value': 'Tacos',
    },
    {
      'display': 'Wraps',
      'value': 'Wraps',
    },
    {
      'display': 'Bread Loaf',
      'value': 'Bread Loaf',
    },
    {
      'display': 'None',
      'value': 'None',
    },
  ];

  List essentials = [
      'Brown Rice',
      'White Rice',
      'All Purpose Flour',
      'Pasta',
      'Cooking Oil',
      'Juices',
      'Protein Bars',
      'Nutella',
      'Peanut Butter',
  ];

  List salads = [
    {
      'display': 'Spring Mix',
      'value': 'Spring Mix',
    },
    {
      'display': 'Spinach',
      'value': 'Spinach',
    },
    {
      'display': 'Lettuce',
      'value': 'Lettuce',
    },
    {
      'display': 'Arugula',
      'value': 'Arugula',
    },
    {
      'display': 'None',
      'value': 'None',
    },
  ];

  List dairy = [
    {
      'display': 'Milk',
      'value': 'Milk',
    },
    {
      'display': 'Half & Half',
      'value': 'Half & Half',
    },
    {
      'display': 'Cream',
      'value': 'Cream',
    },
    {
      'display': 'Yogurt',
      'value': 'Yogurt',
    },
    {
      'display': 'Cheese Slice',
      'value': 'Cheese Slice',
    },
    {
      'display': 'Shredded Cheese',
      'value': 'Shredded Cheese',
    },
    {
      'display': 'Ice Cream',
      'value': 'Ice Cream',
    },
    {
      'display': 'None',
      'value': 'None',
    },
  ];

  List meat = [
    {
      'display': 'Eggs',
      'value': 'Eggs',
    },
    {
      'display': 'Chicken',
      'value': 'Chicken',
    },
    {
      'display': 'Sausages',
      'value': 'Sausages',
    },
    {
      'display': 'Pepperoni',
      'value': 'Pepperoni',
    },
    {
      'display': 'Red Meat',
      'value': 'Red Meat',
    },
    {
      'display': 'Pork',
      'value': 'Pork',
    },
    {
      'display': 'None',
      'value': 'None',
    },
  ];

  List condiments = [
    {
      'display': 'Salt',
      'value': 'Salt',
    },
    {
      'display': 'Pepper',
      'value': 'Pepper',
    },
    {
      'display': 'Garlic Powder',
      'value': 'Garlic Powder',
    },
    {
      'display': 'Onion Flakes',
      'value': 'Onion Flakes',
    },
    {
      'display': 'Red Pepper',
      'value': 'Red Pepper',
    },
    {
      'display': 'None',
      'value': 'None',
    },
  ];

  

  List getVeggies() {
    return veggies;
  }

  List getBreads() {
    return bread;
  }
  
  List getEssentials() {
    return essentials;
  }

  List getSalads() {
    return salads;
  }
  
  List getDairy() {
    return dairy;
  }
  
  List getMeat() {
    return meat;
  }

  List getCondiments() {
    return condiments;
  }
}

final DataService dataService = DataService();