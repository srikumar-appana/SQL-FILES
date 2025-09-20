-- Remove DB creation, just create tables and data in current DB

-- users
CREATE TABLE users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  gender ENUM('Male','Female','Other') NOT NULL,
  date_of_birth DATE NOT NULL,
  phone_number VARCHAR(20),
  profile_created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_login DATETIME NULL,
  is_active TINYINT(1) DEFAULT 1,
  is_premium TINYINT(1) DEFAULT 0
) ENGINE=InnoDB;

CREATE TABLE profiles (
  profile_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL UNIQUE,
  height DECIMAL(4,2),
  religion ENUM('Hindu','Muslim','Christian','Sikh','Jain','Buddhist','Other') NOT NULL,
  caste VARCHAR(100),
  mother_tongue VARCHAR(50) NOT NULL,
  education VARCHAR(255),
  occupation VARCHAR(255),
  annual_income DECIMAL(12,2),
  marital_status ENUM('Never Married','Divorced','Widowed','Awaiting Divorce') DEFAULT 'Never Married',
  about_me TEXT,
  profile_picture_url VARCHAR(500),
  CONSTRAINT fk_profiles_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE family_details (
  family_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL UNIQUE,
  father_name VARCHAR(200),
  father_occupation VARCHAR(255),
  mother_name VARCHAR(200),
  mother_occupation VARCHAR(255),
  siblings INT DEFAULT 0,
  family_status ENUM('Middle Class','Upper Middle Class','Rich','Affluent'),
  family_type ENUM('Joint','Nuclear','Other'),
  CONSTRAINT fk_family_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE partner_preferences (
  preference_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL UNIQUE,
  min_age INT,
  max_age INT,
  min_height DECIMAL(4,2),
  max_height DECIMAL(4,2),
  preferred_religion ENUM('Hindu','Muslim','Christian','Sikh','Jain','Buddhist','Other','Any'),
  preferred_caste VARCHAR(100),
  education_preference VARCHAR(255),
  occupation_preference VARCHAR(255),
  min_income DECIMAL(12,2),
  marital_status_preference ENUM('Never Married','Divorced','Widowed','Awaiting Divorce','Any'),
  CONSTRAINT fk_pref_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE addresses (
  address_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL UNIQUE,
  country VARCHAR(100) DEFAULT 'India',
  state VARCHAR(100),
  city VARCHAR(100),
  pincode VARCHAR(10),
  current_address TEXT,
  permanent_address TEXT,
  CONSTRAINT fk_address_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE user_photos (
  photo_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  photo_url VARCHAR(500) NOT NULL,
  is_primary TINYINT(1) DEFAULT 0,
  uploaded_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_photo_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE interests (
  interest_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  interest_name VARCHAR(100) NOT NULL,
  CONSTRAINT fk_interest_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE messages (
  message_id INT AUTO_INCREMENT PRIMARY KEY,
  sender_id INT NOT NULL,
  receiver_id INT NOT NULL,
  message_text TEXT NOT NULL,
  sent_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  is_read TINYINT(1) DEFAULT 0,
  CONSTRAINT fk_msg_sender FOREIGN KEY (sender_id) REFERENCES users(user_id),
  CONSTRAINT fk_msg_receiver FOREIGN KEY (receiver_id) REFERENCES users(user_id)
) ENGINE=InnoDB;

CREATE TABLE matches (
  match_id INT AUTO_INCREMENT PRIMARY KEY,
  user1_id INT NOT NULL,
  user2_id INT NOT NULL,
  match_score INT,
  matched_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  status ENUM('Pending','Accepted','Rejected') DEFAULT 'Pending',
  CONSTRAINT fk_match_u1 FOREIGN KEY (user1_id) REFERENCES users(user_id),
  CONSTRAINT fk_match_u2 FOREIGN KEY (user2_id) REFERENCES users(user_id)
) ENGINE=InnoDB;

-- Minimal sample data
INSERT INTO users (email, password_hash, first_name, last_name, gender, date_of_birth, phone_number, is_premium) VALUES
('rahul.sharma@example.com','h1','Rahul','Sharma','Male','1990-05-15','+919876543210',1),
('priya.patel@example.com','h2','Priya','Patel','Female','1992-08-22','+919876543211',0),
('amit.kumar@example.com','h3','Amit','Kumar','Male','1988-12-10','+919876543212',1);

INSERT INTO profiles (user_id, height, religion, caste, mother_tongue, education, occupation, annual_income, marital_status, about_me) VALUES
(1, 5.90, 'Hindu', 'Brahmin', 'Hindi', 'MBA', 'Business Analyst', 1200000.00, 'Never Married', 'Looking for a life partner.'),
(2, 5.40, 'Hindu', 'Patel', 'Gujarati', 'M.Sc', 'Software Engineer', 900000.00, 'Never Married', 'Traditional values with modern outlook.'),
(3, 5.80, 'Hindu', 'Rajput', 'Hindi', 'B.Tech', 'IT Manager', 1500000.00, 'Never Married', 'Family-oriented.');

INSERT INTO addresses (user_id, state, city, pincode) VALUES
(1, 'Maharashtra', 'Mumbai', '400001'),
(2, 'Gujarat', 'Ahmedabad', '380001'),
(3, 'Delhi', 'New Delhi', '110001');

INSERT INTO partner_preferences (user_id, min_age, max_age, min_height, max_height, preferred_religion, preferred_caste, education_preference, min_income, marital_status_preference) VALUES
(1,25,30,5.20,5.60,'Hindu','Any','Graduate',800000.00,'Any'),
(2,28,35,5.40,5.80,'Hindu','Any','Post Graduate',1000000.00,'Any'),
(3,26,32,5.30,5.70,'Hindu','Any','Graduate',900000.00,'Any');

INSERT INTO messages (sender_id, receiver_id, message_text) VALUES
(1,2,'Hello Priya, I liked your profile!'),
(2,1,'Hi Rahul, thanks — happy to connect.');

INSERT INTO matches (user1_id, user2_id, match_score, status) VALUES
(1,2,85,'Pending');

-- Example queries
SELECT u.user_id, u.first_name, u.last_name, p.height, p.religion, a.city
FROM users u
JOIN profiles p ON u.user_id = p.user_id
JOIN addresses a ON u.user_id = a.user_id
WHERE u.gender <> (SELECT gender FROM users WHERE user_id = 1)
  AND u.user_id <> 1
  AND u.is_active = 1
ORDER BY p.religion, a.city;

SELECT 
  u.*,
  p.*,
  fd.*,
  a.*,
  pp.*,
  (
    SELECT GROUP_CONCAT(i.interest_name)
    FROM interests i
    WHERE i.user_id = u.user_id
  ) AS interests
FROM users u
LEFT JOIN profiles p ON u.user_id = p.user_id
LEFT JOIN family_details fd ON u.user_id = fd.user_id
LEFT JOIN addresses a ON u.user_id = a.user_id
LEFT JOIN partner_preferences pp ON u.user_id = pp.user_id
WHERE u.user_id = 1;

SELECT gender, COUNT(*) AS total_users
FROM users
WHERE is_active = 1
GROUP BY gender;

CREATE INDEX idx_users_gender ON users(gender);
CREATE INDEX idx_profiles_religion ON profiles(religion);
CREATE INDEX idx_addresses_city ON addresses(city);# SQL-FILES
