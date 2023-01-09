-- Membuat database yummy_yum
CREATE DATABASE yummy_yum;

-- Relasi 1 to 1

-- Membuat tabel user
CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  phone_number VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Membuat tabel recipe
CREATE TABLE recipe (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title VARCHAR(255) NOT NULL,
  ingredients TEXT NOT NULL,
  instructions TEXT NOT NULL,
  saved_recipe INTEGER NOT NULL,
  like_recipe INTEGER NOT NULL,
  video_url VARCHAR(255) DEFAULT NULL,
  image_url VARCHAR(255) DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  user_id INTEGER,
  FOREIGN KEY(user_id) REFERENCES user(id)
);

CREATE:
INSERT INTO user (name, email, phone_number, password) VALUES 
('John', 'john@example.com', '1234567890', 'password123'),
('Jane', 'jane@example.com', '0987654321', 'password456');
INSERT INTO recipe (title, ingredients, instructions, saved_recipe, like_recipe, video_url, image_url, user_id) VALUES 
('Chocolate Cake', '1 cup flour, 1 cup sugar, 1 egg', 'Mix all ingredients together and bake at 350 degrees for 30 minutes', 0, 0, 'https://www.youtube.com/watch?v=abcdefg', 'https://www.example.com/cake.jpg', 1),
('Pizza', '1 cup flour, 1 cup water, 1 tsp yeast', 'Mix flour and water together and add yeast. Roll out dough and add toppings. Bake at 450 degrees for 10-15 minutes', 0, 0, 'https://www.youtube.com/watch?v=hijklmnop', 'https://www.example.com/pizza.jpg', 2);

READ:
SELECT * FROM user;
SELECT * FROM recipe;

UPDATE:
UPDATE user SET email = 'newemail@example.com' WHERE id = 1;
UPDATE recipe SET ingredients = '1 cup flour, 1 cup sugar, 2 eggs' WHERE id = 1;

DELETE:
DELETE FROM user WHERE id = 1;
DELETE FROM recipe WHERE id = 1;

-- Relasi 1 to many

-- Membuat tabel user
CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  phone_number VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Membuat tabel comment
CREATE TABLE comment (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(255) NOT NULL,
  comment TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  recipe_id INTEGER,
  FOREIGN KEY(recipe_id) REFERENCES recipe(id)
);

CREATE:
INSERT INTO user (name, email, phone_number, password) VALUES 
('John', 'john@example.com', '1234567890', 'password123'),
('Jane', 'jane@example.com', '0987654321', 'password456');
INSERT INTO comment (name, comment, recipe_id) V
('John', 'This recipe is delicious!', 1),
('Jane', 'I love this recipe!', 1);

READ:
SELECT * FROM user;
SELECT * FROM comment;

UPDATE:
UPDATE user SET email = 'newemail@example.com' WHERE id = 1;
UPDATE comment SET comment = 'I love this recipe!' WHERE id = 1;

DELETE:
DELETE FROM user WHERE id = 1;
DELETE FROM comment WHERE id = 1;


-- Relasi many to many

-- Membuat tabel recipe
CREATE TABLE recipe (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title VARCHAR(255) NOT NULL,
  ingredients TEXT NOT NULL,
  instructions TEXT NOT NULL,
  saved_recipe INTEGER NOT NULL,
  like_recipe INTEGER NOT NULL,
  video_url VARCHAR(255) DEFAULT NULL,
  image_url VARCHAR(255) DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Membuat tabel comment
CREATE TABLE comment (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(255) NOT NULL,
  comment TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Membuat tabel categories
CREATE TABLE categories (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(255) NOT NULL
);

-- Membuat tabel recipe_categories (junction table)
CREATE TABLE recipe_categories (
  recipe_id INTEGER,
  categories_id INTEGER,
  FOREIGN KEY(recipe_id) REFERENCES recipe(id),
  FOREIGN KEY(categories_id) REFERENCES categories(id)
);

CREATE:
INSERT INTO recipe (title, ingredients, instructions, saved_recipe, like_recipe, video_url, image_url) VALUES 
('Chocolate Cake', '1 cup flour, 1 cup sugar, 1 egg', 'Mix all ingredients together and bake at 350 degrees for 30 minutes', 0, 0, 'https://www.youtube.com/watch?v=abcdefg', 'https://www.example.com/cake.jpg'),
('Pizza', '1 cup flour, 1 cup water, 1 tsp yeast', 'Mix flour and water together and add yeast. Roll out dough and add toppings. Bake at 450 degrees for 10-15 minutes', 0, 0, 'https://www.youtube.com/watch?v=hijklmnop', 'https://www.example.com/pizza.jpg');


INSERT INTO comment (name, comment) VALUES 
('John', 'This recipe is delicious!'),
('Jane', 'I love this recipe!');

-- Menambahkan data ke tabel categories
INSERT INTO categories (name) VALUES 
('Desserts'),
('Entrees');

-- Menambahkan data ke tabel recipe_categories
INSERT INTO recipe_categories (recipe_id, categories_id) VALUES 
(1, 1),
(2, 2);


-- Untuk membaca data dari tabel recipe, comment, categories, dan recipe_categories, Anda dapat menggunakan perintah-perintah SQL berikut:
SELECT * FROM recipe;
SELECT * FROM comment;
SELECT * FROM categories;
SELECT * FROM recipe_categories;

-- Untuk menampilkan data yang terhubung dengan relasi many-to-many, Anda dapat menggunakan perintah JOIN seperti di bawah ini:
SELECT * FROM recipe INNER JOIN recipe_categories ON recipe.id = recipe_categories.recipe_id INNER JOIN categories ON recipe_categories.categories_id = categories.id;
SELECT * FROM recipe INNER JOIN recipe_categories ON recipe.id = recipe_categories.recipe_id INNER JOIN categories ON recipe_categories.categories_id = categories.id INNER JOIN comment ON recipe.id = comment.recipe_id;

UPDATE:
UPDATE recipe SET title = 'Chocolate Chip Cake' WHERE id = 1;
UPDATE comment SET comment = 'This recipe is amazing!' WHERE id = 1;
UPDATE categories SET name = 'Sweets' WHERE id = 1;
UPDATE recipe_categories SET categories_id = 1 WHERE recipe_id = 2;

DELETE:
DELETE FROM recipe WHERE id = 1;
DELETE FROM comment WHERE id = 1;
DELETE FROM categories WHERE id = 1;
DELETE FROM recipe_categories WHERE recipe_id = 1;