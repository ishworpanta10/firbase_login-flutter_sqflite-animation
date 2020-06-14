class Product {
  final String heading;
  final String description;
  final String image;
  final int price;

  Product({this.heading, this.description, this.image, this.price});
  // static List<Product> getProducts() {
  //   List<Product> items = <Product>[];
  //   items.add(
  //     Product(
  //         heading: "Samsung Galaxy Note 10",
  //         description: "256 gb storage and 8 gb ram",
  //         image: "note10.jpg",
  //         price: 120000),
  //   );
  //   items.add(
  //     Product(
  //         heading: "One Plus 7t",
  //         description: "256 gb storage and 8 gb ram",
  //         image: "op7t.jpg",
  //         price: 80000),
  //   );
  //   items.add(
  //     Product(
  //         heading: "Xioami K20 Pro",
  //         description: "256 gb storage and 8 gb ram",
  //         image: "k20pro.jpg",
  //         price: 47000),
  //   );
  //   return items;
  // }
}

List<Product> products = [
  Product(
      heading: "Samsung Galaxy Note 10",
      description: "256 gb storage and 8 gb ram",
      image: "note10.jpg",
      price: 120000),
  Product(
      heading: "One Plus 7t",
      description: "256 gb storage and 8 gb ram",
      image: "op7t.jpg",
      price: 80000),
  Product(
      heading: "Xioami K20 Pro",
      description: "256 gb storage and 8 gb ram",
      image: "k20pro.jpg",
      price: 47000),
  Product(
      heading: "Iphone 11 Pro Max",
      description: "256 gb storage and 4 gb ram",
      image: "iphone11_Pro.png",
      price: 140000),
  Product(
      heading: "Xioami MI Mix Aplha",
      description: "256 gb storage and 8 gb ram",
      image: "mimix.jpg",
      price: 324000),
        Product(
      heading: "Samsung A50S",
      description: "64 gb storage and 4 gb ram",
      image: "samsung_A50.jpg",
      price: 32000),
];
