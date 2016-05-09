require_relative "../core/boot"

def core
  Berg::Container
end

def main
  Main::Container
end

def admin
  Admin::Container
end

def create_user(attrs)
  if !admin["admin.persistence.repositories.users"].by_email(attrs[:email])
    admin["admin.users.operations.create"].call(attrs).value
  end
end

def create_post(attrs)
  if !admin["admin.persistence.repositories.posts"].by_slug(attrs[:slug])
    admin["admin.posts.operations.create"].call(attrs).value
  end
end

create_user(
  email: "hello@icelab.com.au",
  first_name: "Icelab",
  last_name: "Admin",
  active: true
)

author = admin["admin.persistence.repositories.users"].by_email("hello@icelab.com.au")
create_post(
  title: "This is a test post",
  teaser: "You won't want to miss this post",
  body: "Some sample content for this test post",
  slug: "this-is-a-test-post",
  status: "draft",
  author_id: author.id
)
