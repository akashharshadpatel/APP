import Foundation

/// Realistic sample data used until the Dutchie API is connected.
/// Brands are fictional. Prices are typical for New Jersey adult-use retail.
enum MockData {

    // MARK: - Store

    // PLACEHOLDER: replace address, phone, license number and hours with TreeHouse's real details.
    static let store = StoreInfo(
        name: "TreeHouse",
        subtitle: "Central Jersey Dispensary",
        licenseNumber: "NJ CRC License # (placeholder)",
        street: "123 Easton Ave",
        city: "Somerset",
        state: "NJ",
        postalCode: "08873",
        phoneNumber: "(732) 555-0142",
        latitude: 40.4976,
        longitude: -74.4885,
        hours: [
            StoreHours(weekday: 1, opensAt: 10 * 60, closesAt: 18 * 60),
            StoreHours(weekday: 2, opensAt: 9 * 60, closesAt: 21 * 60),
            StoreHours(weekday: 3, opensAt: 9 * 60, closesAt: 21 * 60),
            StoreHours(weekday: 4, opensAt: 9 * 60, closesAt: 21 * 60),
            StoreHours(weekday: 5, opensAt: 9 * 60, closesAt: 21 * 60),
            StoreHours(weekday: 6, opensAt: 9 * 60, closesAt: 22 * 60),
            StoreHours(weekday: 7, opensAt: 9 * 60, closesAt: 22 * 60),
        ]
    )

    // MARK: - Products

    private static let flowerSizes: [(String, Double)] = [("3.5g", 3.5), ("7g", 7), ("14g", 14), ("28g", 28)]

    static let products: [Product] = [
        // Flower
        flower("fl-blue-dream", "Blue Dream", brand: "Pine Barrens Farms", strain: .sativa, thc: 24.6,
               effects: [.uplifted, .creative, .happy], terpenes: ["Myrcene", "Pinene", "Caryophyllene"],
               prices: [50, 95, 175, 320], staffPick: true,
               summary: "A sweet berry aroma with a smooth, balanced finish. A long-time favorite for daytime."),
        flower("fl-gelato-41", "Gelato #41", brand: "Garden State Grown", strain: .hybrid, thc: 27.3,
               effects: [.euphoric, .relaxed, .creative], terpenes: ["Limonene", "Caryophyllene", "Linalool"],
               prices: [60, 110, 200, 360], salePercent: 0.2,
               summary: "Dense, frosty buds with dessert-like notes of sherbet and citrus."),
        flower("fl-wedding-cake", "Wedding Cake", brand: "Raritan Reserve", strain: .indica, thc: 26.1,
               effects: [.relaxed, .happy, .hungry], terpenes: ["Limonene", "Caryophyllene", "Myrcene"],
               prices: [55, 100, 185, 340], staffPick: true,
               summary: "Rich vanilla and earthy pepper. Rounded and mellow for winding down."),
        flower("fl-sour-diesel", "Sour Diesel", brand: "Shore Cultivation", strain: .sativa, thc: 22.4,
               effects: [.energetic, .uplifted, .focused], terpenes: ["Caryophyllene", "Myrcene", "Limonene"],
               prices: [45, 85, 160, 300],
               summary: "Pungent, fuel-forward aroma with a bright citrus edge."),
        flower("fl-gdp", "Granddaddy Purple", brand: "Pine Barrens Farms", strain: .indica, thc: 21.8,
               effects: [.sleepy, .relaxed, .calm], terpenes: ["Myrcene", "Pinene", "Caryophyllene"],
               prices: [45, 85, 160, 300], salePercent: 0.15,
               summary: "Deep purple buds with grape and berry notes. A classic evening strain."),
        flower("fl-runtz", "Runtz", brand: "Garden State Grown", strain: .hybrid, thc: 28.9,
               effects: [.euphoric, .giggly, .happy], terpenes: ["Caryophyllene", "Limonene", "Linalool"],
               prices: [65, 120, 220, 400], isNew: true,
               summary: "Candy-sweet and fruity with a creamy exhale. Top-shelf potency."),
        flower("fl-jack-herer", "Jack Herer", brand: "Highlands Craft", strain: .sativa, thc: 23.2,
               effects: [.focused, .creative, .uplifted], terpenes: ["Terpinolene", "Pinene", "Caryophyllene"],
               prices: [50, 95, 175, 320],
               summary: "Spicy pine and woody notes. Clear-headed and bright."),
        flower("fl-northern-lights", "Northern Lights", brand: "Shore Cultivation", strain: .indica, thc: 19.7,
               effects: [.relaxed, .sleepy, .calm], terpenes: ["Myrcene", "Caryophyllene", "Limonene"],
               prices: [40, 75, 140, 260], salePercent: 0.25,
               summary: "Earthy, sweet and resinous. Gentle and easygoing."),
        flower("fl-ice-cream-cake", "Ice Cream Cake", brand: "Raritan Reserve", strain: .indica, thc: 25.4,
               effects: [.relaxed, .happy, .sleepy], terpenes: ["Limonene", "Caryophyllene", "Linalool"],
               prices: [55, 100, 185, 340], isNew: true,
               summary: "Creamy vanilla and sugary dough. Smooth from start to finish."),
        flower("fl-super-lemon-haze", "Super Lemon Haze", brand: "Highlands Craft", strain: .sativa, thc: 22.9,
               effects: [.energetic, .talkative, .happy], terpenes: ["Terpinolene", "Limonene", "Ocimene"],
               prices: [50, 95, 175, 320],
               summary: "Zesty lemon peel and sweet haze. Lively and social."),
        flower("fl-harlequin", "Harlequin", brand: "Pine Barrens Farms", strain: .cbd, thc: 6.2, cbd: 11.4,
               effects: [.calm, .focused, .relaxed], terpenes: ["Myrcene", "Pinene"],
               prices: [40, 75],
               summary: "A CBD-forward flower with mild THC. Earthy mango and pine."),

        // Pre-rolls
        preroll("pr-blue-dream-1g", "Blue Dream Pre-Roll", brand: "Pine Barrens Farms", strain: .sativa, thc: 23.8,
                effects: [.uplifted, .creative], variants: [("1g", 1, 15), ("5 × 0.5g", 2.5, 40)], staffPick: true),
        preroll("pr-gelato-infused", "Gelato Infused Pre-Roll", brand: "Highlands Extracts", strain: .hybrid, thc: 38.5,
                effects: [.euphoric, .relaxed], variants: [("1g", 1, 22)], isNew: true),
        preroll("pr-gdp-minis", "GDP Minis", brand: "Shore Cultivation", strain: .indica, thc: 21.1,
                effects: [.sleepy, .relaxed], variants: [("7 × 0.35g", 2.45, 35)], salePercent: 0.2),
        preroll("pr-sour-d", "Sour Diesel Pre-Roll", brand: "Shore Cultivation", strain: .sativa, thc: 21.9,
                effects: [.energetic, .focused], variants: [("1g", 1, 14), ("2 × 1g", 2, 26)]),
        preroll("pr-wedding-cake", "Wedding Cake Pre-Roll", brand: "Raritan Reserve", strain: .indica, thc: 25.0,
                effects: [.relaxed, .happy], variants: [("1g", 1, 16)]),

        // Vapes
        vape("vp-blue-dream-cart", "Blue Dream Cartridge", brand: "Boardwalk Botanicals", strain: .sativa, thc: 86.2,
             effects: [.uplifted, .creative], variants: [("0.5g", 0.5, 40), ("1g", 1, 65)], staffPick: true),
        vape("vp-gdp-live-resin", "GDP Live Resin Cart", brand: "Highlands Extracts", strain: .indica, thc: 81.4,
             effects: [.sleepy, .relaxed], variants: [("0.5g", 0.5, 45), ("1g", 1, 75)], salePercent: 0.15),
        vape("vp-runtz-aio", "Runtz All-in-One", brand: "Boardwalk Botanicals", strain: .hybrid, thc: 88.9,
             effects: [.euphoric, .happy], variants: [("0.5g", 0.5, 45)], isNew: true),
        vape("vp-jack-herer-cart", "Jack Herer Cartridge", brand: "Boardwalk Botanicals", strain: .sativa, thc: 84.7,
             effects: [.focused, .energetic], variants: [("0.5g", 0.5, 40), ("1g", 1, 65)]),
        vape("vp-cbd-1-1", "Balance 1:1 Cartridge", brand: "Turnpike Tonics", strain: .cbd, thc: 42.0, cbd: 41.5,
             effects: [.calm, .relaxed], variants: [("0.5g", 0.5, 45)]),

        // Edibles
        edible("ed-watermelon-gummies", "Watermelon Gummies", brand: "Turnpike Tonics", strain: .sativa, thcMG: 100,
               effects: [.happy, .uplifted], variants: [("10 × 10mg", 28)], staffPick: true,
               summary: "Juicy watermelon gummies, 10mg THC each. Start low and go slow."),
        edible("ed-blackberry-sleep", "Blackberry Night Gummies", brand: "Turnpike Tonics", strain: .indica, thcMG: 100, cbdMG: 50,
               effects: [.sleepy, .relaxed], variants: [("10 × 10mg", 30)], salePercent: 0.2,
               summary: "Blackberry gummies with 10mg THC and 5mg CBD each. Made for evenings."),
        edible("ed-dark-chocolate", "Dark Chocolate Squares", brand: "Boardwalk Botanicals", strain: .hybrid, thcMG: 100,
               effects: [.relaxed, .happy], variants: [("10 × 10mg", 25)],
               summary: "70% dark chocolate, scored into 10 pieces of 10mg THC."),
        edible("ed-peach-mints", "Peach Ring Mints", brand: "Turnpike Tonics", strain: .hybrid, thcMG: 100,
               effects: [.happy, .giggly], variants: [("20 × 5mg", 26)], isNew: true,
               summary: "Low-dose 5mg mints for a lighter experience."),
        edible("ed-cbd-calm", "CBD Calm Chews", brand: "Garden State Grown", strain: .cbd, thcMG: 50, cbdMG: 200,
               effects: [.calm, .focused], variants: [("10 chews", 32)],
               summary: "20:5 CBD:THC chews with a mellow citrus flavor."),

        // Concentrates
        concentrate("cn-gelato-badder", "Gelato Live Badder", brand: "Highlands Extracts", strain: .hybrid, thc: 76.4,
                    effects: [.euphoric, .relaxed], variants: [("1g", 1, 60)], staffPick: true),
        concentrate("cn-sour-d-shatter", "Sour Diesel Shatter", brand: "Highlands Extracts", strain: .sativa, thc: 81.2,
                    effects: [.energetic, .focused], variants: [("1g", 1, 50)], salePercent: 0.2),
        concentrate("cn-gdp-rosin", "GDP Live Rosin", brand: "Raritan Reserve", strain: .indica, thc: 72.8,
                    effects: [.sleepy, .relaxed], variants: [("1g", 1, 75)], isNew: true),
        concentrate("cn-runtz-diamonds", "Runtz Diamonds", brand: "Highlands Extracts", strain: .hybrid, thc: 91.3,
                    effects: [.euphoric, .happy], variants: [("1g", 1, 70)]),

        // Tinctures
        Product(id: "tn-balance", name: "Balance 1:1 Tincture", brand: "Turnpike Tonics", category: .tinctures,
                strainType: .cbd, summary: "300mg THC and 300mg CBD in a 30ml bottle with a measured dropper.",
                potency: Potency(thc: 300, cbd: 300, unit: .milligrams), effects: [.calm, .relaxed],
                terpenes: [], variants: [variant("tn-balance-30", "30ml", grams: nil, price: 65, stock: 14)],
                imageURL: nil, isStaffPick: false, isNew: false),
        Product(id: "tn-night", name: "Night Drops", brand: "Turnpike Tonics", category: .tinctures,
                strainType: .indica, summary: "300mg THC with CBN in an MCT oil base.",
                potency: Potency(thc: 300, cbd: 30, unit: .milligrams), effects: [.sleepy, .calm],
                terpenes: ["Myrcene", "Linalool"],
                variants: [variant("tn-night-30", "30ml", grams: nil, price: 60, sale: 48, stock: 9)],
                imageURL: nil, isStaffPick: false, isNew: true),

        // Topicals
        Product(id: "tp-cooling-balm", name: "Cooling Balm", brand: "Garden State Grown", category: .topicals,
                strainType: .cbd, summary: "Menthol and eucalyptus balm with 100mg THC and 300mg CBD. For external use only.",
                potency: Potency(thc: 100, cbd: 300, unit: .milligrams), effects: [.calm],
                terpenes: [], variants: [variant("tp-cooling-balm-2oz", "2 oz", grams: nil, price: 40, stock: 20)],
                imageURL: nil, isStaffPick: false, isNew: false),
        Product(id: "tp-body-lotion", name: "Lavender Body Lotion", brand: "Boardwalk Botanicals", category: .topicals,
                strainType: .cbd, summary: "A light lavender lotion with 50mg THC and 150mg CBD. For external use only.",
                potency: Potency(thc: 50, cbd: 150, unit: .milligrams), effects: [.calm, .relaxed],
                terpenes: ["Linalool"], variants: [variant("tp-body-lotion-4oz", "4 oz", grams: nil, price: 35, stock: 0)],
                imageURL: nil, isStaffPick: false, isNew: false),

        // Accessories
        accessory("ac-grinder", "TreeHouse Grinder", brand: "TreeHouse", price: 20,
                  summary: "4-piece aluminum grinder with the TreeHouse logo."),
        accessory("ac-battery", "510 Vape Battery", brand: "Boardwalk Botanicals", price: 18,
                  summary: "Variable-voltage battery for 510-thread cartridges. USB-C charging."),
        accessory("ac-papers", "Hemp Rolling Papers", brand: "Garden State Grown", price: 4,
                  summary: "Unbleached hemp papers with tips."),
        accessory("ac-stash-jar", "Smell-Proof Stash Jar", brand: "TreeHouse", price: 25,
                  summary: "UV-protective glass jar with an airtight, child-resistant lid."),
    ]

    // MARK: - Deals

    static let deals: [Deal] = [
        Deal(id: "deal-first-order", title: "15% Off Your First Order",
             subtitle: "Welcome to TreeHouse", badge: "15% OFF",
             details: "New customers save 15% on their first pickup order placed in the app.",
             finePrint: "Applied at pickup. One per customer. Cannot be combined with other offers.",
             symbolName: "gift.fill", category: nil, productIDs: [], endsAt: nil),
        Deal(id: "deal-flower-friday", title: "Flower Friday",
             subtitle: "Select flower up to 25% off", badge: "UP TO 25% OFF",
             details: "Save on select flower from Garden State Grown, Pine Barrens Farms and Shore Cultivation.",
             finePrint: "While supplies last. Prices as marked.",
             symbolName: "leaf.fill", category: .flower,
             productIDs: ["fl-gelato-41", "fl-gdp", "fl-northern-lights"], endsAt: daysFromNow(3)),
        Deal(id: "deal-edibles", title: "Edibles Sale",
             subtitle: "20% off Blackberry Night Gummies", badge: "20% OFF",
             details: "Turnpike Tonics' best-selling evening gummies are on sale this week.",
             finePrint: "While supplies last.",
             symbolName: "birthday.cake.fill", category: .edibles,
             productIDs: ["ed-blackberry-sleep"], endsAt: daysFromNow(5)),
        Deal(id: "deal-concentrates", title: "Extract Week",
             subtitle: "Select concentrates and carts on sale", badge: "15–20% OFF",
             details: "Savings on Highlands Extracts shatter and live resin cartridges.",
             finePrint: "While supplies last. Prices as marked.",
             symbolName: "drop.fill", category: .concentrates,
             productIDs: ["cn-sour-d-shatter", "vp-gdp-live-resin", "pr-gdp-minis"], endsAt: daysFromNow(6)),
        Deal(id: "deal-veterans", title: "Veterans & Seniors",
             subtitle: "10% off every day", badge: "10% OFF",
             details: "Veterans and customers 65+ save 10% every day. Show a valid ID at pickup.",
             finePrint: "Valid ID required at pickup. Cannot be combined with other offers.",
             symbolName: "star.fill", category: nil, productIDs: [], endsAt: nil),
    ]

    // MARK: - Loyalty

    static let loyaltyAccount = LoyaltyAccount(
        points: 340,
        lifetimePoints: 820,
        memberSince: daysFromNow(-240),
        rewards: [
            Reward(id: "rw-5", title: "$5 Off", details: "Take $5 off any order.", pointsCost: 100, symbolName: "dollarsign.circle.fill"),
            Reward(id: "rw-10", title: "$10 Off", details: "Take $10 off any order.", pointsCost: 180, symbolName: "dollarsign.circle.fill"),
            Reward(id: "rw-grinder", title: "TreeHouse Grinder", details: "A free branded grinder with your next order.", pointsCost: 250, symbolName: "gearshape.fill"),
            Reward(id: "rw-25", title: "$25 Off", details: "Take $25 off any order of $75 or more.", pointsCost: 400, symbolName: "dollarsign.circle.fill"),
            Reward(id: "rw-tote", title: "TreeHouse Tote", details: "A canvas tote bag from our merch line.", pointsCost: 500, symbolName: "bag.fill"),
        ],
        activity: [
            PointsActivity(id: "pa-1", date: daysFromNow(-3), title: "Order TH-4790", points: 72),
            PointsActivity(id: "pa-2", date: daysFromNow(-12), title: "Redeemed $10 Off", points: -180),
            PointsActivity(id: "pa-3", date: daysFromNow(-12), title: "Order TH-4702", points: 118),
            PointsActivity(id: "pa-4", date: daysFromNow(-30), title: "Order TH-4588", points: 95),
            PointsActivity(id: "pa-5", date: daysFromNow(-45), title: "Birthday Bonus", points: 100),
        ]
    )

    // MARK: - Past orders

    static var pastOrders: [Order] {
        [
            pastOrder(number: "TH-4790", daysAgo: 3, items: [("fl-blue-dream", 0, 1), ("ed-watermelon-gummies", 0, 1)]),
            pastOrder(number: "TH-4702", daysAgo: 12, items: [("vp-blue-dream-cart", 1, 1), ("pr-blue-dream-1g", 1, 1), ("ac-grinder", 0, 1)]),
            pastOrder(number: "TH-4588", daysAgo: 30, items: [("fl-wedding-cake", 1, 1), ("ed-dark-chocolate", 0, 2)]),
        ]
    }

    // MARK: - Builders

    static func daysFromNow(_ days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: days, to: .now) ?? .now
    }

    private static func variant(_ id: String, _ label: String, grams: Double?, price: Decimal,
                                sale: Decimal? = nil, stock: Int) -> ProductVariant {
        ProductVariant(id: id, label: label, weightGrams: grams, price: price, salePrice: sale, quantityAvailable: stock)
    }

    /// Whole-dollar sale price.
    private static func discounted(_ price: Decimal, by percent: Double?) -> Decimal? {
        guard let percent else { return nil }
        return Decimal(Int((price.doubleValue * (1 - percent)).rounded()))
    }

    /// Deterministic stock level so the same products are low/out of stock every launch.
    private static func stock(for id: String, index: Int) -> Int {
        let seed = id.unicodeScalars.reduce(index) { $0 + Int($1.value) }
        return [0, 3, 8, 12, 20, 25, 30][seed % 7] + (index == 0 ? 4 : 0)
    }

    private static func flower(_ id: String, _ name: String, brand: String, strain: StrainType,
                               thc: Double, cbd: Double = 0.1, effects: [Effect], terpenes: [String],
                               prices: [Decimal], salePercent: Double? = nil, staffPick: Bool = false,
                               isNew: Bool = false, summary: String) -> Product {
        let variants = zip(flowerSizes, prices).enumerated().map { index, pair in
            let ((label, grams), price) = pair
            return variant("\(id)-\(label)", label, grams: grams, price: price,
                           sale: discounted(price, by: salePercent), stock: stock(for: id, index: index))
        }
        return Product(id: id, name: name, brand: brand, category: .flower, strainType: strain, summary: summary,
                       potency: Potency(thc: thc, cbd: cbd, unit: .percent), effects: effects, terpenes: terpenes,
                       variants: variants, imageURL: nil, isStaffPick: staffPick, isNew: isNew)
    }

    private static func weighed(_ id: String, _ name: String, brand: String, category: ProductCategory,
                                strain: StrainType, thc: Double, cbd: Double, effects: [Effect],
                                variants specs: [(String, Double, Decimal)], salePercent: Double?,
                                staffPick: Bool, isNew: Bool, summary: String) -> Product {
        let variants = specs.enumerated().map { index, spec in
            variant("\(id)-\(index)", spec.0, grams: spec.1, price: spec.2,
                    sale: discounted(spec.2, by: salePercent), stock: stock(for: id, index: index))
        }
        return Product(id: id, name: name, brand: brand, category: category, strainType: strain, summary: summary,
                       potency: Potency(thc: thc, cbd: cbd, unit: .percent), effects: effects, terpenes: [],
                       variants: variants, imageURL: nil, isStaffPick: staffPick, isNew: isNew)
    }

    private static func preroll(_ id: String, _ name: String, brand: String, strain: StrainType, thc: Double,
                                effects: [Effect], variants: [(String, Double, Decimal)],
                                salePercent: Double? = nil, staffPick: Bool = false, isNew: Bool = false) -> Product {
        weighed(id, name, brand: brand, category: .prerolls, strain: strain, thc: thc, cbd: 0.1, effects: effects,
                variants: variants, salePercent: salePercent, staffPick: staffPick, isNew: isNew,
                summary: "Hand-finished pre-rolls made with whole flower. No trim or shake.")
    }

    private static func vape(_ id: String, _ name: String, brand: String, strain: StrainType, thc: Double,
                             cbd: Double = 0.2, effects: [Effect], variants: [(String, Double, Decimal)],
                             salePercent: Double? = nil, staffPick: Bool = false, isNew: Bool = false) -> Product {
        weighed(id, name, brand: brand, category: .vapes, strain: strain, thc: thc, cbd: cbd, effects: effects,
                variants: variants, salePercent: salePercent, staffPick: staffPick, isNew: isNew,
                summary: "Strain-specific cannabis oil with botanical terpenes in a ceramic 510-thread cartridge.")
    }

    private static func concentrate(_ id: String, _ name: String, brand: String, strain: StrainType, thc: Double,
                                    effects: [Effect], variants: [(String, Double, Decimal)],
                                    salePercent: Double? = nil, staffPick: Bool = false, isNew: Bool = false) -> Product {
        weighed(id, name, brand: brand, category: .concentrates, strain: strain, thc: thc, cbd: 0.3, effects: effects,
                variants: variants, salePercent: salePercent, staffPick: staffPick, isNew: isNew,
                summary: "Small-batch extract made from fresh-frozen flower. Intended for experienced consumers.")
    }

    private static func edible(_ id: String, _ name: String, brand: String, strain: StrainType, thcMG: Double,
                               cbdMG: Double = 0, effects: [Effect], variants specs: [(String, Decimal)],
                               salePercent: Double? = nil, staffPick: Bool = false, isNew: Bool = false,
                               summary: String) -> Product {
        let variants = specs.enumerated().map { index, spec in
            variant("\(id)-\(index)", spec.0, grams: nil, price: spec.1,
                    sale: discounted(spec.1, by: salePercent), stock: stock(for: id, index: index))
        }
        return Product(id: id, name: name, brand: brand, category: .edibles, strainType: strain, summary: summary,
                       potency: Potency(thc: thcMG, cbd: cbdMG, unit: .milligrams), effects: effects, terpenes: [],
                       variants: variants, imageURL: nil, isStaffPick: staffPick, isNew: isNew)
    }

    private static func accessory(_ id: String, _ name: String, brand: String, price: Decimal, summary: String) -> Product {
        Product(id: id, name: name, brand: brand, category: .accessories, strainType: nil, summary: summary,
                potency: nil, effects: [], terpenes: [],
                variants: [variant("\(id)-0", "Each", grams: nil, price: price, stock: 15)],
                imageURL: nil, isStaffPick: false, isNew: false)
    }

    private static func pastOrder(number: String, daysAgo: Int, items: [(String, Int, Int)]) -> Order {
        let lines: [OrderLine] = items.compactMap { productID, variantIndex, quantity in
            guard let product = products.first(where: { $0.id == productID }),
                  product.variants.indices.contains(variantIndex) else { return nil }
            let variant = product.variants[variantIndex]
            return OrderLine(productID: product.id, variantID: variant.id, productName: product.name,
                             brand: product.brand, variantLabel: variant.label, category: product.category,
                             strainType: product.strainType, unitPrice: variant.price, quantity: quantity)
        }
        let subtotal = lines.reduce(Decimal(0)) { $0 + $1.lineTotal }
        let tax = MockDutchieService.estimatedTax(on: subtotal)
        let created = daysFromNow(-daysAgo)
        let slot = PickupSlot(id: "\(number)-slot", start: created.addingTimeInterval(3600),
                              end: created.addingTimeInterval(5400), isAvailable: true)
        return Order(id: number, number: number, createdAt: created, pickupSlot: slot, lines: lines,
                     subtotal: subtotal, savings: 0, estimatedTax: tax, total: subtotal + tax,
                     status: .completed, customerName: "Alex")
    }
}
