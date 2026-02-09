require "ostruct"

# Stub Stripe API calls so seeding works without Stripe credentials
puts "Stubbing Stripe API for seeding..."
Stripe::Customer.define_singleton_method(:create) { |**_args| OpenStruct.new(id: "cus_seed_#{rand(100_000)}") }

Stripe::Product.define_singleton_method(:create) { |**_args| OpenStruct.new(id: "prod_seed_#{rand(100_000)}") }

Stripe::Price.define_singleton_method(:create) { |**_args| OpenStruct.new(id: "price_seed_#{rand(100_000)}") }

puts "Destroying user"
User.destroy_all

puts "Creating user"
user_admin = User.create!(email: "toto@gmail.com", password: "qwertz", admin: true)
user_admin_2 = User.create!(email: "tata@gmail.com", password: "qwertz", admin: true)
User.create!(email: "titi@gmail.com", password: "qwertz")

puts "Cleaning database..."
Clothe.destroy_all

puts "Creating clothes..."

products = [
  {
    name: "T-shirt TBM Classic",
    description: "Le pilier de la collection Tudo Bem Maman. Coupe droite et décontractée, ce t-shirt en coton peigné accompagne toutes vos journées avec style. Le logo TBM brodé sur la poitrine apporte une touche d'authenticité streetwear.",
    price: 2500,
    size: "M",
    category: "classique",
    image: "t-shirt-tmb.png",
    content_type: "image/png",
    sales_count: 47
  },
  {
    name: "T-shirt TBM Classic",
    description: "Même coupe iconique, en taille L. Tissu doux et respirant, idéal pour un look casual au quotidien. Le t-shirt que vous allez porter tous les jours sans vous lasser.",
    price: 2500,
    size: "L",
    category: "classique",
    image: "t-shirt-tmb.png",
    content_type: "image/png",
    sales_count: 31
  },
  {
    name: "T-shirt TBM Classic",
    description: "Le Classic en version XL pour un fit oversize assumé. Le dos arbore le visuel signature TBM, parfait pour ceux qui veulent affirmer leur style de dos comme de face.",
    price: 2500,
    size: "XL",
    category: "classique",
    image: "t-shirt-dos-tbm.png",
    content_type: "image/png",
    sales_count: 12
  },
  {
    name: "T-shirt TBM Lover",
    description: "Édition limitée pour les vrais fans. Le TBM Lover affiche un design exclusif avec des finitions premium. Coton épais et coupe ajustée, c'est la pièce collector de la saison.",
    price: 2900,
    size: "S",
    category: "limited",
    image: "tshirt-tbmlover.jpg",
    content_type: "image/jpeg",
    sales_count: 58
  },
  {
    name: "T-shirt TBM Lover",
    description: "Le Lover en taille M, notre bestseller toutes tailles confondues. Son graphisme unique et ses couleurs vibrantes en font une pièce incontournable de votre garde-robe streetwear.",
    price: 2900,
    size: "M",
    category: "limited",
    image: "tshirt-tbmlover.jpg",
    content_type: "image/jpeg",
    sales_count: 42
  },
  {
    name: "T-shirt Surf TBM",
    description: "Inspiré par les vagues et le soleil. Le Surf TBM capture l'esprit bord de mer avec un visuel graphique évoquant les sessions de surf au coucher du soleil. Parfait pour l'été.",
    price: 3200,
    size: "M",
    category: "surf",
    image: "surf-tbm.png",
    content_type: "image/png",
    sales_count: 23
  },
  {
    name: "T-shirt Surf TBM",
    description: "Le Surf TBM en taille L pour un fit relaxed. Coton léger et fluide, idéal pour les journées chaudes. Le visuel imprimé par sérigraphie résiste aux lavages et au sel.",
    price: 3200,
    size: "L",
    category: "surf",
    image: "surf-tbm.png",
    content_type: "image/png",
    sales_count: 19
  },
  {
    name: "T-shirt Louis TBM",
    description: "La ligne premium de Tudo Bem Maman. Le Louis TBM combine un coton peigné haute densité avec un design minimaliste et des finitions haut de gamme. Col renforcé et coutures doubles.",
    price: 3500,
    size: "S",
    category: "premium",
    image: "louis-tbm.png",
    content_type: "image/png",
    sales_count: 35
  },
  {
    name: "T-shirt Louis TBM",
    description: "Le Louis en taille M, l'alliance du confort et de l'élégance. Chaque détail est pensé : étiquette tissée, ourlet roulé, coton extra-doux 200g/m². Une pièce qui se bonifie avec le temps.",
    price: 3500,
    size: "M",
    category: "premium",
    image: "louis-tbm.png",
    content_type: "image/png",
    sales_count: 27
  },
  {
    name: "T-shirt TBM Classic",
    description: "Le Classic en taille S, parfait pour un fit ajusté et élégant. Le visuel dos met en avant le logo TBM dans un style vintage qui rappelle les origines de la marque.",
    price: 2500,
    size: "S",
    category: "classique",
    image: "t-shirt-dos-tbm.png",
    content_type: "image/png",
    sales_count: 15
  }
]

products.each do |product|
  image_path = Rails.root.join("app/assets/images/#{product[:image]}")

  clothe = Clothe.create!(
    name: product[:name],
    description: product[:description],
    price: product[:price],
    size: product[:size],
    category: product[:category],
    user: user_admin
  )

  clothe.image.attach(
    io: File.open(image_path),
    filename: product[:image],
    content_type: product[:content_type]
  )

  clothe.update_column(:sales_count, product[:sales_count])

  puts "  Created: #{product[:name]} (#{product[:size]}) — #{product[:sales_count]} sales"
end

puts "Finished! #{Clothe.count} products created."
