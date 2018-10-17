namespace :fake do

  USER_NUM  = 20
  POST_NUM = 20
  COMMENT_NUM = 20
  MAX_COMMENT = 20

  task fake_user: :environment do
    User.destroy_all

    User.create(
      name: "Dojo",
      email: "admin@example.com",
      password: "12345678",
      intro: "Dojo Fourm Admin",
      role: "admin"
    )

    USER_NUM.times do |i|
      name = FFaker::Name::first_name
      file = File.open("#{Rails.root}/app/assets/images/avatar/user#{(i%20)+1}.jpg")

      User.create!(
        name: "#{name}",
        email: "user_#{i.to_s}@xplorer.com",
        password: "12345678",
        intro: FFaker::Lorem::sentence(30),
        avatar: file
      )
    end
    puts "have created fake users"
    puts "now you have #{User.count} user data (#{User.first.id}..#{User.last.id})"
  end

  task fake_post: :environment do
    Post.destroy_all

    User.all.each do |user|
      rand(1..POST_NUM).times do |i|
      # user.posts.create()
        Post.create(
          user_id: user.id
        )
      end
    end

    Post.all.each do |post|
      file = File.open("#{Rails.root}/app/assets/images/post/post#{rand(1..20)}.jpg")

      post.title = "Post_#{post.id}"
      post.content = FFaker::Lorem::sentence(500)
      post.draft = (rand(1..300)%2 == 0) ? "false" : "true"
      post.image = file
      post.viewed_count = rand(1..300)
      post.permission = (rand(1..300)%10 == 0) ? "myself" : (rand(1..300)%10 == 0) ? "friend" : "all"
      post.save!
    end

    puts "have created fake posts"
    puts "now you have #{Post.count} posts data (#{Post.first.id}..#{Post.last.id})"
  end

  task fake_comment: :environment do
    Comment.destroy_all
    User.all.each do |user|
      count = 0
      MAX_COMMENT.times do |j|
        post = Post.all.sample
      # user.comments.create(
        Comment.create(
          user_id: user.id,
          post_id: post.id,
        # post: post,
          content: FFaker::Lorem::sentence(30)
        )
        count = count + 1
      end
      puts "have created #{count} comments for user #{user.name}"
    end
    puts "now you have #{Comment.count} comments data (#{Comment.first.id}..#{Comment.last.id})"
  end

  task fake_post_category: :environment do
    PostCategory.destroy_all

    Post.all.each do |post|
      rand(1..Category.count).times do |i|
        PostCategory.create!(
          post_id: post.id,
          category_id: Category.all.sample.id
        )
      end
    end
  end

################################################################################

  task fake_all: :environment do
    puts "fake_user processing..."
    Rake::Task['fake:fake_user'].execute
    puts "fake_post processing..."
    Rake::Task['fake:fake_post'].execute
    puts "fake_comment processing..."
    Rake::Task['fake:fake_comment'].execute
    puts "fake_post_category processing..."
    Rake::Task['fake:fake_post_category'].execute
  end
end