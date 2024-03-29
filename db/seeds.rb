puts "Destroying user"
User.destroy_all

puts "Creating user"
user_admin = User.create!(email: "toto@gmail.com", password: "qwertz", admin: true)
user_admin_2 = User.create!(email: "tata@gmail.com", password: "qwertz", admin: true)
User.create!(email: "titi@gmail.com", password: "qwertz")

puts "Cleaning database..."
Clothe.destroy_all

puts "Creating clothe"

clothe = Clothe.create!(name: "T-shirt TBM", description: "Notre t-shirt Tudo Bem Maman est fait en 100% coton, avec des coutures résistantes et amples", price: 22, size: "M", category: "tshrit", user: user_admin)
clothe_image = Cloudinary::Uploader.upload(Rails.root.join("app/assets/images/t-shirt-dos-tbm.png"))
clothe.image.attach(io: URI.open(clothe_image['secure_url']), filename: "t-shirt-dos-tbm.png", content_type: "image/png")

clothe = Clothe.create!(name: "T-shirt TBM", description: "Notre t-shirt Tudo Bem Maman est fait en 100% coton, avec des coutures résistantes et amples", price: 22, size: "M", category: "tshrit", user: user_admin)
clothe_image = Cloudinary::Uploader.upload(Rails.root.join("app/assets/images/t-shirt-dos-tbm.png"))
clothe.image.attach(io: URI.open(clothe_image['secure_url']), filename: "t-shirt-dos-tbm.png", content_type: "image/png")

clothe = Clothe.create!(name: "T-shirt TBM", description: "Notre t-shirt Tudo Bem Maman est fait en 100% coton, avec des coutures résistantes et amples", price: 22, size: "M", category: "tshrit", user: user_admin)
clothe_image = Cloudinary::Uploader.upload(Rails.root.join("app/assets/images/t-shirt-dos-tbm.png"))
clothe.image.attach(io: URI.open(clothe_image['secure_url']), filename: "t-shirt-dos-tbm.png", content_type: "image/png")

puts "Finished!"
