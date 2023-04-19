puts "Destroying user"
User.destroy_all

puts "Creating user"
user_admin = User.create!(email: "toto@gmail.com", password: "qwertz", admin: true)
User.create!(email: "titi@gmail.com", password: "qwertz")

puts "Cleaning database..."
Clothe.destroy_all

puts "Creating clothe"

clothe = Clothe.create!(name: "T-shirt TBM", description: "Notre t-shirt Tudo Bem Maman est fait en 100% coton, avec des coutures résistantes et amples", price: 22, size: "M", category: "tshrit", user: user_admin)
clothe_image = Cloudinary::Uploader.upload("app/assets/images/tshirt-tbmlover.jpg")
clothe.image.attach(io: URI.open(clothe_image['url']), filename: "tshirt-tbmlover.jpg", content_type: "image/jpg")

clothe = Clothe.create!(name: "T-shirt TBM", description: "Notre t-shirt Tudo Bem Maman est fait en 100% coton, avec des coutures résistantes et amples", price: 22, size: "M", category: "tshrit", user: user_admin)
clothe_image = Cloudinary::Uploader.upload("app/assets/images/tshirt-tbmlover.jpg")
clothe.image.attach(io: URI.open(clothe_image['url']), filename: "tshirt-tbmlover.jpg", content_type: "image/jpg")

clothe = Clothe.create!(name: "T-shirt TBM", description: "Notre t-shirt Tudo Bem Maman est fait en 100% coton, avec des coutures résistantes et amples", price: 22, size: "M", category: "tshrit", user: user_admin)
clothe_image = Cloudinary::Uploader.upload("app/assets/images/tshirt-tbmlover.jpg")
clothe.image.attach(io: URI.open(clothe_image['url']), filename: "tshirt-tbmlover.jpg", content_type: "image/jpg")

puts "Finished!"
