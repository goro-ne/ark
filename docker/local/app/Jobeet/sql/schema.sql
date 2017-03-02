SET foreign_key_checks=0;

CREATE TABLE jobeet_affiliate (
  id INTEGER unsigned NOT NULL auto_increment,
  url VARCHAR(191) NOT NULL,
  email VARCHAR(191) NOT NULL,
  token VARCHAR(80) NOT NULL,
  is_active TINYINT unsigned NOT NULL DEFAULT 0,
  created_at datetime NOT NULL,
  PRIMARY KEY (id),
  UNIQUE jobeet_affiliate_email (email)
);

CREATE TABLE jobeet_category (
  id INTEGER unsigned NOT NULL auto_increment,
  name VARCHAR(191) NOT NULL,
  slug VARCHAR(191) NULL,
  PRIMARY KEY (id),
  UNIQUE jobeet_category_name (name),
  UNIQUE jobeet_category_slug (slug)
) ENGINE=InnoDB;

CREATE TABLE jobeet_category_affiliate (
  category_id INTEGER unsigned NOT NULL auto_increment,
  affiliate_id INTEGER unsigned NOT NULL,
  PRIMARY KEY (category_id, affiliate_id)
);

CREATE TABLE jobeet_job (
  id INTEGER unsigned NOT NULL auto_increment,
  category_id INTEGER unsigned NOT NULL,
  type VARCHAR(191) NOT NULL,
  company VARCHAR(191) NOT NULL,
  logo VARCHAR(191) NOT NULL,
  url VARCHAR(191) NOT NULL,
  position VARCHAR(191) NOT NULL,
  location VARCHAR(191) NOT NULL,
  description text NOT NULL,
  how_to_apply VARCHAR(191) NOT NULL,
  is_public TINYINT NOT NULL DEFAULT 1,
  is_activated TINYINT NOT NULL DEFAULT 0,
  token VARCHAR(191) NOT NULL,
  email VARCHAR(191) NOT NULL,
  expires_at datetime NOT NULL,
  created_at datetime NOT NULL,
  updated_at datetime NOT NULL,
  INDEX jobeet_job_idx_category_id (category_id),
  PRIMARY KEY (id),
  UNIQUE jobeet_job_token (token),
  CONSTRAINT jobeet_job_fk_category_id FOREIGN KEY (category_id) REFERENCES jobeet_category (id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

SET foreign_key_checks=1;

