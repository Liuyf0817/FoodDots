//
//  Fruit.swift
//  FoodDots
//
//  Created by yanfeng liu on 19/11/21.
//

import Foundation
import SwiftUI

protocol Detailable {
    var name: String { get }
    var desc: String { get }
}

enum Category: String, CaseIterable, Codable, Hashable {
    case Fruit
    case Vegetable
    case Filter
}

struct Food: Identifiable, Codable, Hashable {
    var id: String
    var name: String
    var imageName: String
    var category: Category
    var description: String
    var price: Double
}

extension Food: Detailable {
    
    var desc: String {
        return description
    }
}

func foodDictionaryFrom(food: Food) -> [String: Any] {
    
    return NSDictionary(objects: [
        food.id,
        food.name,
        food.imageName,
        food.category.rawValue,
        food.description,
        food.price
    ], forKeys: [
        kID as NSCopying,
        kNAME as NSCopying,
        kIMAGENAME as NSCopying,
        kCATEGORY as NSCopying,
        kDESCRIPTION as NSCopying,
        kPRICE as NSCopying
    ]) as! [String : Any]
}

func createMenu() {
    for food in foodData {
        FirebaseReference(.Menu).addDocument(data: foodDictionaryFrom(food: food))
    }
}

let foodData = [
    //Fruit
    Food(id: UUID().uuidString, name: "Apple", imageName: "apple", category: Category.Fruit, description: "An apple is an edible fruit produced by an apple tree. Apple trees are cultivated worldwide and are the most widely grown species in the genus Malus. The tree originated in Central Asia, where its wild ancestor, Malus sieversii, is still found today.", price: 2.50),
    
    Food(id: UUID().uuidString, name: "Avocado", imageName: "avocado", category: Category.Fruit, description: "Avocado trees produce clusters of small, green-yellow flowers at the end of twigs and a large, fleshy, pear-shaped fruit with a single large seed. The fruits can be purple to green in color with smooth or warty skin depending on variety. The flesh of the fruit is yellow-green in color and has the consistency of butter.", price: 2.00),
    
    Food(id: UUID().uuidString, name: "Banana", imageName: "banana", category: Category.Fruit, description: "A banana is a curved, yellow fruit with a thick skin and soft sweet flesh. If you eat a banana every day for breakfast, your roommate might nickname you \"the monkey.\" A banana is a tropical fruit that's quite popular all over the world. It grows in bunches on a banana tree.", price: 2.50),
    
    Food(id: UUID().uuidString, name: "Blueberry", imageName: "blueberries", category: Category.Fruit, description: "Blueberry is a crown forming, woody, perennial shrub in the family Ericaceae grown for its fruits, or berries, of the same name. The blueberry plant possesses oval or elliptical leaves which grow alternately on the stems. The stems, or twigs, are yellow/green in color and turn reddish in winter.", price: 2.50),
        
                    
    Food(id: UUID().uuidString, name: "Cherry", imageName: "cherries", category: Category.Fruit, description: "cherry, any of various trees belonging to the genus Prunus and their edible fruits. ... The fruit is a fleshy drupe (stone fruit) that is generally heart-shaped to nearly globular, about 2 cm (1 inch) in diameter, and varies in colour from yellow through red to nearly black. The acid content of the sweet cherry is low.", price: 2.00),
    
    Food(id: UUID().uuidString, name: "Citrus", imageName: "citrus", category: Category.Fruit, description: "any of a group of often thorny trees and shrubs (Citrus and related genera) of the rue family grown in warm regions for their edible fruit (such as the orange or lemon) with firm usually thick rind and pulpy flesh also : the fruit.", price: 2.00),

    Food(id: UUID().uuidString, name: "Kiwi", imageName: "kiwi", category: Category.Fruit, description: "The ellipsoidal kiwi fruit is a true berry and has furry brownish green skin. The firm translucent green flesh has numerous edible purple-black seeds embedded around a white centre. The deciduous leaves are borne alternately on long petioles (leaf stems), and young leaves are covered with reddish hairs.", price: 2.50),

    Food(id: UUID().uuidString, name: "Persimmon", imageName: "persimmon", category: Category.Fruit, description: "A persimmon is an edible fruit (a berry, specifically) that grows on a variety of trees in the genus Diospyros. The most widely cultivated among these is the Diospyros kaki, or the Asian persimmon. When ripe, persimmons range in color from light yellow to dark red-orange. They range in size and shape, too.", price: 2.00),

    
    Food(id: UUID().uuidString, name: "Strawberry", imageName: "strawberry", category: Category.Fruit, description: "A strawberry is both a low-growing, flowering plant and also the name of the fruit that it produces. Strawberries are soft, sweet, bright red berries. They're also delicious. Strawberries have tiny edible seeds, which grow all over their surface. When ripe, strawberries smell wonderful and taste even better.", price: 5.00),
    
    Food(id: UUID().uuidString, name: "Tangerine", imageName: "tangerine", category: Category.Fruit, description: "Tangerines are smaller and less rounded than common oranges. The taste is considered less sour, as well as sweeter and stronger, than that of an orange. A ripe tangerine is firm to slightly soft, and pebbly-skinned with no deep grooves, as well as orange in color. The peel is thin, with little bitter white mesocarp.", price: 5.00),
    
    //Veg
    Food(id: UUID().uuidString, name: "Tomato", imageName: "tomato", category: Category.Vegetable, description: "They are usually red, scarlet, or yellow, though green and purple varieties do exist, and they vary in shape from almost spherical to oval and elongate to pear-shaped. Each fruit contains at least two cells of small seeds surrounded by jellylike pulp. hothouse tomatoes.", price: 4.00),
    
    Food(id: UUID().uuidString, name: "Potato", imageName: "potato", category: Category.Vegetable, description: "The potato is one of some 150 tuber-bearing species of the genus Solanum (a tuber is the swollen end of an underground stem). The compound leaves are spirally arranged; each leaf is 20–30 cm (about 8–12 inches) long and consists of a terminal leaflet and two to four pairs of leaflets.", price: 2.00),
    
    Food(id: UUID().uuidString, name: "Onion", imageName: "onion", category: Category.Vegetable, description: "An onion is a round vegetable with a brown skin that grows underground. It has many white layers on its inside which have a strong, sharp smell and taste. ... It is made with fresh minced meat, cooked with onion and a rich tomato sauce.", price: 2.50),
    
    Food(id: UUID().uuidString, name: "Eggplant", imageName: "eggplant", category: Category.Vegetable, description: "Eggplant, Solanum melongena, is a tropical, herbaceous, perennial plant, closely related to tomato, in the family Solanaceae which is grown for its edible fruit. ... The fruit is a large, fleshy ovoid berry which can reach 40 cm (15.7 in) in length, with glossy smooth skin and numerous small seeds.", price: 2.30),
    
    Food(id: UUID().uuidString, name: "Broccoli", imageName: "broccoli", category: Category.Vegetable, description: "Broccoli, Brassica oleracea, is an herbaceous annual or biennial grown for its edible flower heads which are used as a vegetable. The broccoli plant has a thick green stalk, or stem, which gives rise to thick, leathery, oblong leaves which are gray-blue to green in color.", price: 3.50),
    
    Food(id: UUID().uuidString, name: "Bell Pepper", imageName: "bell-pepper", category: Category.Vegetable, description: "Bell peppers are a variety of Capsicum annuum that come in almost every shade of the rainbow, including red, yellow, orange, green, chocolate/brown, vanilla/white, and purple. They are not a spicy pepper, but range from being bitter and vegetal to sweet and fruity.", price: 2.60),
    
    Food(id: UUID().uuidString, name: "Cucumber", imageName: "cucumber", category: Category.Vegetable, description: "Cucumber, Cucumis sativus, is a warm season, vining, annual plant in the family Cucurbitaceae grown for its edible cucumber fruit. The cucumber plant is a sprawling vine with large leaves and curling tendrils. ... The leaves of the plant are arranged alternately on the vines, have 3–7 pointed lobes and are hairy.", price: 2.60)
    
]

