# List of all S3 buckets used for storage, the class dictates if it is S3 or glacier
#
#

#-----------------------------------------#
# Adult                                   #
# Usage: Backup                           #
# Class: Glacier                          #
# Versioned: false                        #
# Lifecycle: 1 Day -> Glacier             #
#-----------------------------------------#
resource "aws_s3_bucket" "adult_ceng" {
  # resource name

  bucket = "adult_ceng" # bucket name
  acl    = "private"

  versioning {
    enabled = false
  }

  lifecycle_rule {
    id      = "adult-glacier"
    prefix  = ""              # setting this to an empty string means the entire bucket will adhere to the rule
    enabled = true

    transition {
      days          = 1         # transistions occur at midnight in the timezone of the bucket.
      storage_class = "GLACIER"
    }
  }
}

resource "aws_s3_bucket_object" "videos" {
  # Do not hardcode the bucket name here. Besides being ugly, you will run the risk of the folder resources being created before the bucket and causing a failed run. By using the terrafrom DSL you are creating a dependency between the object resource and the bucket resource.
  bucket = "${aws_s3_bucket.adult_ceng.bucket}"

  # This is creating a folder strucutre using 0 byte files. The trailing slash is necessary, if it is omitted then you will end up with an empty file instead of a directory.
  key = "videos/"

  # This is the path to 0 byte file that will be uploaded, the simplest way to create it is to use `touch`.
  source = "objects/videos"
}

resource "aws_s3_bucket_object" "pictures" {
  bucket = "${aws_s3_bucket.adult_ceng.bucket}"
  key    = "pictures/"
  source = "objects/pictures"
}

#-----------------------------------------#
# Applications                            #
# Usage: Backup                           #
# Class: Glacier                          #
# Versioned: false                        #
# Lifecycle: 1 Day -> Glacier             #
#-----------------------------------------#
resource "aws_s3_bucket" "applications_ceng" {
  bucket = "applications_ceng"
  acl    = "private"

  versioning {
    enabled = false
  }

  lifecycle_rule {
    id      = "apps"
    prefix  = ""
    enabled = true

    transition {
      days          = 1
      storage_class = "GLACIER"
    }
  }
}

## Android ##
resource "aws_s3_bucket_object" "android" {
  bucket = "${aws_s3_bucket.applications_ceng.bucket}"
  key    = "android/"
  source = "objects/android"
}

## Linux ##
resource "aws_s3_bucket_object" "linux" {
  bucket = "${aws_s3_bucket.applications_ceng.bucket}"
  key    = "linux/"
  source = "objects/linux"
}

## Nintendo ##
resource "aws_s3_bucket_object" "nintendo" {
  bucket = "${aws_s3_bucket.applications_ceng.bucket}"
  key    = "nintendo/"
  source = "objects/nintendo"
}

## Playstation ##
resource "aws_s3_bucket_object" "playstation" {
  bucket = "${aws_s3_bucket.applications_ceng.bucket}"
  key    = "playstation/"
  source = "objects/playstation"
}

## OSX ##
resource "aws_s3_bucket_object" "osx" {
  bucket = "${aws_s3_bucket.applications_ceng.bucket}"
  key    = "osx/"
  source = "objects/osx"
}

## Other ##
resource "aws_s3_bucket_object" "other" {
  bucket = "${aws_s3_bucket.applications_ceng.bucket}"
  key    = "other/"
  source = "objects/other"
}

## Windows ##
resource "aws_s3_bucket_object" "windows" {
  bucket = "${aws_s3_bucket.applications_ceng.bucket}"
  key    = "windows/"
  source = "objects/windows"
}

#-----------------------------------------#
# Books                                   #
# Usage: Backup                           #
# Class: Glacier                          #
# Versioned: false                        #
# Lifecycle: Standard                     #
#-----------------------------------------#
resource "aws_s3_bucket" "books_ceng" {
  bucket = "books_ceng"
  acl    = "private"

  versioning {
    enabled = false
  }

  /*lifecycle_rule {
                    id      = "books"
                    prefix  = ""
                    enabled = true

                    transition {
                      days          = 1
                      storage_class = "GLACIER"
                    }
                  }*/
}

#-----------------------------------------#
# Comics                                  #
# Usage: Backup                           #
# Class: Glacier                          #
# Versioned: false                        #
# Lifecycle: Standard                     #
#-----------------------------------------#
resource "aws_s3_bucket" "comics_ceng" {
  bucket = "comics_ceng"
  acl    = "private"

  versioning {
    enabled = false
  }

  /*lifecycle_rule {
                    id      = "comics"
                    prefix  = ""
                    enabled = true

                    transition {
                      days          = 1
                      storage_class = "GLACIER"
                    }
                  }*/
}

resource "aws_s3_bucket_object" "marvel" {
  bucket = "${aws_s3_bucket.comics_ceng.bucket}"
  key    = "marvel/"
  source = "objects/marvel"
}

resource "aws_s3_bucket_object" "dc" {
  bucket = "${aws_s3_bucket.comics_ceng.bucket}"
  key    = "dc/"
  source = "objects/dc"
}

#-----------------------------------------#
# Documents                               #
# Usage: Backup                           #
# Class: Infrequent Access                #
# Class: Glacier                          #
# Versioned: false                        #
# Lifecycle: Standard                     #
#-----------------------------------------#
resource "aws_s3_bucket" "documents_ceng" {
  bucket = "documents_ceng"
  acl    = "private"

  versioning {
    enabled = false
  }
}

#-----------------------------------------#
# Media                                   #
# Usage: Backup                           #
# Class: Glacier                          #
# Versioned: false                        #
# Lifecycle: 1 Day -> Glacier             #
#-----------------------------------------#
resource "aws_s3_bucket" "media_ceng" {
  bucket = "media_ceng"
  acl    = "private"

  versioning {
    enabled = false
  }

  lifecycle_rule {
    id      = "media"
    prefix  = ""
    enabled = true

    transition {
      days          = 1
      storage_class = "GLACIER"
    }
  }
}

resource "aws_s3_bucket_object" "clips" {
  bucket = "${aws_s3_bucket.media_ceng.bucket}"
  key    = "clips/"
  source = "objects/clips"
}

resource "aws_s3_bucket_object" "personal" {
  bucket = "${aws_s3_bucket.media_ceng.bucket}"
  key    = "personal/"
  source = "objects/personal"
}

resource "aws_s3_bucket_object" "movies" {
  bucket = "${aws_s3_bucket.media_ceng.bucket}"
  key    = "movies/"
  source = "objects/movies"
}

resource "aws_s3_bucket_object" "tech" {
  bucket = "${aws_s3_bucket.media_ceng.bucket}"
  key    = "tech/"
  source = "objects/tech"
}

resource "aws_s3_bucket_object" "tv-shows" {
  bucket = "${aws_s3_bucket.media_ceng.bucket}"
  key    = "tv-shows/"
  source = "objects/tv-shows"
}

#-----------------------------------------#
# Music                                   #
# Usage: Backup                           #
# Class: Glacier                          #
# Versioned: false                        #
# Lifecycle: 1 Day -> Glacier             #
#-----------------------------------------#
resource "aws_s3_bucket" "music_ceng" {
  bucket = "music_ceng"
  acl    = "private"

  versioning {
    enabled = false
  }

  lifecycle_rule {
    id      = "music"
    prefix  = ""
    enabled = true

    transition {
      days          = 1
      storage_class = "GLACIER"
    }
  }
}

resource "aws_s3_bucket_object" "artists" {
  bucket = "${aws_s3_bucket.music_ceng.bucket}"
  key    = "artists/"
  source = "objects/artists"
}

#-----------------------------------------#
# Pictures                                #
# Usage: Backup                           #
# Class: Glacier                          #
# Versioned: false                        #
# Lifecycle: Standard                     #
#-----------------------------------------#
resource "aws_s3_bucket" "pictures_ceng" {
  bucket = "pictures_ceng"
  acl    = "private"

  versioning {
    enabled = false
  }

  /*lifecycle_rule {
                  id      = "pictures"
                  prefix  = ""
                  enabled = true

                  transition {
                    days          = 1
                    storage_class = "GLACIER"
                  }
                }*/
}

#-----------------------------------------#
# Projects                                #
# Usage: Backup                           #
# Class: Glacier                          #
# Versioned: False                        #
# Lifecycle: 1 Day -> Glacier             #
#-----------------------------------------#
resource "aws_s3_bucket" "projects_ceng" {
  bucket = "projects_ceng"
  acl    = "private"

  versioning {
    enabled = false
  }

  lifecycle_rule {
    id      = "projects"
    prefix  = ""
    enabled = true

    transition {
      days          = 1
      storage_class = "GLACIER"
    }
  }
}

#-----------------------------------------#
# Secure                                  #
# Usage: Backup                           #
# Class: Standard                         #
# Versioned: False                        #
# Lifecycle:                              #
#-----------------------------------------#
resource "aws_s3_bucket" "projects_secure" {
  bucket = "projects_secure"
  acl    = "private"

  versioning {
    enabled = false
  }
}
